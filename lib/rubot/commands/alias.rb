module Rubot
  module Commands
    class Alias < Command
      ALIAS_REGEXP = /[щшк]е ти викаме? (?<new_name>[[:alnum:]]+)/.freeze

      command ALIAS_REGEXP do |client, data, match|
        Rubot.remember do |memory|
          memory[:aliases] ||= []
          memory[:aliases] |= [match[:new_name]]
        end

        SlackRubyBot.configure do |config|
          config.aliases |= Rubot.memory[:aliases]
        end

        client.say channel: data.channel,
                   text: Response.ok
      end
    end
  end
end
