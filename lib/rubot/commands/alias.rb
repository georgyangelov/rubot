module Rubot
  module Commands
    class Alias < Command
      ALIAS_REGEXPS = [
        /[щшк]е ти викаме? (?<new_name>[[:alnum:]]+)/i,
        /[щшк]е те наричаме? (?<new_name>[[:alnum]]+)/i,
      ].deep_freeze

      desc 'Ще те наричам <име>', 'Започва да отговаря на това име в съответния канал.'
      commands ALIAS_REGEXPS do |client, data, match|
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
