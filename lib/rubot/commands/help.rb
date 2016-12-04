module Rubot
  module Commands
    class Help < Rubot::Command
      COMMAND = /(помощ|хелп|help|подарък|чорап)/i

      command COMMAND do |client, data, _|
        help = Rubot.command_descriptions.map do |(command, text)|
          "#{command.ljust(25)} - #{text}"
        end.join("\n")

        client.say channel: data.channel, text: "Ето какво мога: \n\n```#{help}```"
      end
    end
  end
end
