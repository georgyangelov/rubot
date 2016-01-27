module Rubot
  module Commands
    class Alias < Command
      ALIAS_REGEXP = /[щшк]е ти викаме? (?<new_name>[[:alnum:]]+)/.freeze

      desc 'ще ти викам <име>', 'Започва да отговаря на това име.'
      command ALIAS_REGEXP do |client, data, match|
        Rubot.remember(data.channel) do |memory|
          memory[:aliases] ||= []
          memory[:aliases] |= [match[:new_name]]
        end

        client.say channel: data.channel,
                   text: Response.ok
      end
    end
  end
end
