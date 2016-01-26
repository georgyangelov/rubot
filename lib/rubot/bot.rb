module Rubot
  class Bot < SlackRubyBot::Bot
    def self.names(channel = nil)
      if channel
        Rubot::CONFIG['aliases'] | (Rubot.memory.for_channel(channel)[:aliases] || [])
      else
        Rubot::CONFIG['aliases']
      end
    end

    def self.replies_to?(name, channel = nil)
      names(channel).any? do |known_name|
        name.mb_chars.downcase == known_name.mb_chars.downcase
      end
    end
  end
end
