module Rubot
  module Commands
    class Remember < Command
      REMEMBER_LIST_COMMANDS = [
        /запомни (?<value>.+) като (?<key>[[:alnum:]]+)/i,
        /запомни,? че (?<value>.+) (са|сме) (?<key>[[:alnum:]]+)/i,
      ].deep_freeze

      desc 'запомни <елементи> като <списък>', 'Запомня списък за текущия канал.'
      desc 'запомни, че <елементи> са <вид>', 'Запомня списък за текущия канал.'
      commands REMEMBER_LIST_COMMANDS do |client, data, match|
        key = Rubot::KeyNormalizer.normalize(match[:key])
        value = Rubot::NaturalLists.parse(match[:value])

        if value.empty?
          client.say channel: data.channel,
                     text: Response.input_error("Нещо не е наред в `#{match[:value]}`.")
          next
        end

        Rubot.remember(data.channel) do |memory|
          memory[:lists] ||= {}
          memory[:lists][key] = value
        end

        client.say channel: data.channel,
                   text: Response.ok
      end

      SHOW_LIST_COMMANDS = [
        /покажи (?<key>[[:alnum:]]+)/i,
        /(кои|кой) (са|е) (?<key>[[:alnum:]]+)/i,
      ].deep_freeze

      desc 'покажи <списък>', 'Показва елементите на списък.'
      desc 'кои са <списък>', 'Показва елементите на списък.'
      commands SHOW_LIST_COMMANDS do |client, data, match|
        key = Rubot::KeyNormalizer.normalize(match[:key])

        channel_memory = Rubot.memory.for_channel(data.channel)

        if !channel_memory[:lists] || !channel_memory[:lists][key]
          client.say channel: data.channel,
                     text: Response.input_error("Няма списък `#{match[:key]}`.")
          next
        end

        items = channel_memory[:lists][key]

        if items.empty?
          client.say channel: data.channel,
                     text: Response.input_error("Няма никой от `#{match[:key]}`.")
          next
        end

        client.say channel: data.channel,
                   text: Rubot::NaturalLists.construct(items)
      end
    end
  end
end
