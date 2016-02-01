module Rubot
  module Commands
    class Help < Rubot::Command
      COMMAND = /(помощ|помогни( ми)?|хелп|help)/
      COMMAND_CODE = /(къде ти е кода|дай( си)? кода)/

      desc 'помощ', 'Принтира това съобщение'
      command COMMAND do |client, data, _|
        help = Rubot.command_descriptions.map do |(command, text)|
          "`#{command}` - #{text}"
        end.join("\n")

        client.say channel: data.channel,
                   text: help
      end

      desc 'къде ти е код(а|ът)', 'Дава линк към репото си'
      command COMMAND_CODE do |client, data, _|
        client.say channel: data.channel,
                   text: 'https://github.com/stormbreakerbg/rubot'
      end
    end
  end
end
