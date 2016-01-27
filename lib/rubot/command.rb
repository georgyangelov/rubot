module Rubot
  class Command < Listener
    def self.command(regex, &block)
      command_matcher = /\A(?<bot>@?[[:alnum:]]+)[\.,?!]?\s*#{regex}[.?!]*\z/i

      listen_for command_matcher, &block
    end

    def self.commands(regexes, &block)
      regexes.each { |regex| command(regex, &block) }
    end
  end
end
