module Rubot
  module Commands
    class RandomizeList < Command
      COMMANDS = [
        /(дай|избери|искам|търся) (?<count>[[:alnum:]]+)( от)? (?<key>[[:alnum:]]+)( без (?<except>.+?))?/,
      ].deep_freeze

      RESPONSES = [
        'Ето - %s.',
        '%s. Пак заповядай.',
        '%s. Няма нужда да ми благодариш.',
        'Избрах %s.',
      ].deep_freeze

      PLURAL_RESPONSES = [
        'Щастливците са %s.',
        '%s, това сте вие!',
      ].deep_freeze

      SINGULAR_RESPONSES = [
        'Щастливецът е %s.',
        '%s, това си ти! :niki-kan4ev:',
      ].deep_freeze

      commands COMMANDS do |client, data, match|
        key = Rubot::KeyNormalizer.normalize(match[:key])
        count = Rubot::CountParser.parse(match[:count].strip)

        unless count
          client.say channel: data.channel,
                     text: Response.input_error("`#{match[:count]}` не е бройка.")
          next
        end

        if count.zero?
          client.say channel: data.channel,
                     text: 'Избрах празното множество.'
          next
        end

        channel_memory = Rubot.memory.for_channel(data.channel)

        if !channel_memory[:lists] || !channel_memory[:lists][key]
          client.say channel: data.channel,
                     text: Response.input_error("Няма такъв списък `#{match[:key]}`.")
          next
        end

        items = channel_memory[:lists][key]

        if items.empty?
          client.say channel: data.channel,
                     text: Response.input_error("Няма никой от `#{match[:key]}`.")
          next
        end

        if match[:except]
          except = Rubot::NaturalLists.parse(match[:except])

          if except.size >= items.size
            client.say channel: data.channel,
                       text: 'Избрах празното множество.'
            next
          end

          items -= except
        end

        chosen_items = items.sample(count)
        chosen_items_natural_list = Rubot::NaturalLists.construct(chosen_items)

        valid_responses = if count > 1
                            RESPONSES + PLURAL_RESPONSES
                          else
                            RESPONSES + SINGULAR_RESPONSES
                          end

        client.say channel: data.channel,
                   text: valid_responses.sample % chosen_items_natural_list
      end
    end
  end
end
