module Rubot
  module Commands
    class Remember < Command
      REMEMBER_LIST_COMMANDS = [
        /запомни (?<value>.+) като (?<key>[[:alnum:]]+)/,
        /запомни,? че (?<value>.+) (са|сме) (?<key>[[:alnum:]]+)/,
      ].deep_freeze

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
    end
  end
end
