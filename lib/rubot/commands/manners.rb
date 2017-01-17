module Rubot
  module Commands
    class Manners < Rubot::Command
      THANK_YOU = /(благодаря|мерси)/i

      desc 'Благодаря/мерси', 'Показва добри обноски'
      command THANK_YOU do |client, data, _|
        client.say channel: data.channel,
                   text: "Но моля ви се, удоволствието беше мое!"
      end
    end
  end
end
