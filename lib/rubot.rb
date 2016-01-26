require 'slack-ruby-bot'
require 'yaml'

require 'rubot/version'

require 'rubot/bot'
require 'rubot/memory'

require 'rubot/command'
require 'rubot/response'
require 'rubot/commands/alias'
require 'rubot/commands/ping_pong'
require 'rubot/commands/unknown'

module SlackRubyBot
  module Hooks
    module Message
      # Monkey-patch to ensure that our unknown command class is called last
      def command_classes
        Rubot::Command.descendants -
          [Rubot::Commands::Unknown] +
          [Rubot::Commands::Unknown]
      end
    end
  end
end

module Rubot
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end

  def self.memory
    @memory ||= Memory.new(File.join(root, 'config', 'memory.yml'))
  end

  def self.remember
    yield memory

    memory.save
  end

  SECRETS = YAML.load_file(File.join(root, 'config', 'secrets.yml'))
  CONFIG = YAML.load_file(File.join(root, 'config', 'rubot.yml'))
end

ENV['SLACK_API_TOKEN'] = Rubot::SECRETS['slack']['token']

SlackRubyBot.configure do |config|
  config.aliases = Rubot::CONFIG['aliases'] | (Rubot.memory[:aliases] || [])
end
