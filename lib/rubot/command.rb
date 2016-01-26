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

    # Monkey-patch to allow custom bot name handling
    def self.invoke(client, data)
      self.finalize_routes!

      expression, text = parse(client, data)
      called = false

      routes.each_pair do |route, method|
        match = route.match(expression)
        match ||= route.match(text) if text

        next unless match
        next if match.names.include?('bot') &&
                !Rubot::Bot.replies_to?(match['bot'], data.channel) &&
                match['bot'] != client.name

        called = true

        if method
          method.call(client, data, match)
        elsif self.respond_to?(:call)
          send(:call, client, data, match)
        else
          fail NotImplementedError, data.text
        end

        break
      end

      called
    end
  end
end
