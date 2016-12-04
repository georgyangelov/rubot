require 'slack-ruby-bot'
require 'yaml'
require 'mqtt'
require 'active_support/all'
require 'logging'

require 'rubot/lib/deep_freeze'

require 'rubot/version'

require 'rubot/bot'
require 'rubot/memory'
require 'rubot/key_normalizer'
require 'rubot/count_parser'
require 'rubot/natural_lists'

require 'rubot/listener'
require 'rubot/command'
require 'rubot/response'

require 'rubot/http_requests'

require 'rubot/listeners/when_did_you_come'

module Rubot
  cattr_accessor :command_descriptions

  def self.logger
    @logger ||= begin

      log_layout = Logging::Layouts.pattern(pattern: "%d %-5l -- %m\n")

      logger = Logging::Logger.new('rubot')
      logger.add_appenders(
        Logging.appenders.stdout(layout: log_layout),
        Logging.appenders.rolling_file(
          "#{root}/log/#{environment}.log",
          roll_by: :date,
          age: 'weekly',
          layout: log_layout
        )
      )
      logger.level = config[:log_level]
      logger
    end
  end

  def self.root
    @root ||= File.join(File.dirname(__FILE__), '..')
  end

  def self.environment
    @environment ||= begin
      env = ENV['RACK_ENV'] || 'development'
      valid = %w(development production test).include? env

      raise "Unknown environment #{env}" unless valid

      env
    end
  end

  def self.memory
    @memory ||= Memory.new(File.join(root, 'data', 'memory.yml'))
  end

  def self.remember(channel = nil)
    if channel
      yield memory.for_channel(channel)
    else
      yield memory
    end

    memory.save
  end

  def self.config
    @config ||= begin
      config = YAML.load_file(File.join(root, 'config', 'rubot.yml'))

      raise "No config specified for #{environment}" unless config[environment]

      config[environment].deep_freeze.with_indifferent_access
    end
  end

  def self.secrets
    @secrets ||= begin
      secrets = YAML.load_file(File.join(root, 'config', 'secrets.yml'))

      raise "No secrets specified for #{environment}" unless secrets[environment]

      secrets[environment].deep_freeze.with_indifferent_access
    end
  end
end

require 'rubot/commands/admin'
require 'rubot/commands/help'
require 'rubot/commands/alias'
require 'rubot/commands/ping_pong'
require 'rubot/commands/santa_wishes'
require 'rubot/commands/unknown'

module SlackRubyBot
  module Hooks
    module Message
      # Monkey-patch to ensure that our unknown command class is called last
      def command_classes
        (Rubot::Listener.descendants -
          Rubot::Command.descendants +
          Rubot::Command.descendants
        ).uniq -
          [Rubot::Commands::Unknown] +
          [Rubot::Commands::Unknown]
      end
    end
  end
end

ENV['SLACK_API_TOKEN'] = Rubot.secrets[:slack][:token]

require 'byebug' if Rubot.environment != 'production'

Time.zone_default = Time.find_zone!(Rubot.config[:timezone])
