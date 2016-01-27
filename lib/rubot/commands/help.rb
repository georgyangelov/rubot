module Rubot
  module Commands
    class Help < Rubot::Command
      COMMAND = /(помощ|помогни( ми)?|хелп|help)/

      desc 'помощ', 'Принтира това съобщение'
      command COMMAND do |client, data, _|
        help = Rubot.command_descriptions.map do |(command, text)|
          "`#{command}` - #{text}"
        end.join("\n")

        client.say channel: data.channel,
                   text: help
      end
    end
  end
end
