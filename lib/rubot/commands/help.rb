module Rubot
  module Commands
    class Help < Rubot::Command
      COMMAND = /(помощ|помогни( ми)?|хелп|help)/i
      COMMAND_CODE = /(къде ти е кода|дай( си)? кода)/i

      command COMMAND do |client, data, _|
        help = Rubot.command_descriptions.map do |(command, text)|
          "#{command.ljust(25)} - #{text}"
        end.join("\n")

        client.say channel: data.channel, text: "Ето какво мога: \n\n```#{help}```"
      end

      desc 'Къде ти е кодът?', 'Дава линк към репото си'
      command COMMAND_CODE do |client, data, _|
        client.say channel: data.channel,
                   text: 'https://github.com/georgyangelov/rubot'
      end
    end
  end
end
