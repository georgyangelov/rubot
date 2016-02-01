$:.unshift "#{File.dirname(__FILE__)}/../lib"

require 'slack-ruby-bot/rspec'
require 'rubot'

require_relative 'support/memory'
require_relative 'support/commands'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.default_formatter = 'doc'
end
