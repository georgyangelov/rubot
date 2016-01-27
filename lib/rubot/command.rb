module Rubot
  class Command < Listener
    def self.command(regex, &block)
      command_matcher = /\A(?<bot>@?[[:alnum:]]+)[\.,?!]?\s*#{regex}[.?!]*\z/i

      listen_for command_matcher, &block
    end
  end
end
