module Rubot
  class Command < SlackRubyBot::Commands::Base
    def self.command(regex)
      command_matcher = /\A(?<bot>@?[[:alnum:]]+)[\.,?!]?\s*#{regex}[.?!]*\z/i

      match command_matcher do |client, data, match|
        begin
          yield client, data, match
        rescue StandardError => error
          client.say channel: data.channel,
                     text: Response.error(error.message)

          puts error.message
          puts error.backtrace
        end
      end
    end
  end
end
