module Rubot
  module Commands
    class PingPong < Rubot::Command
      command(/дай/) do |client, data, _|
        client.say channel: data.channel, text: 'на ти'
      end
    end
  end
end
