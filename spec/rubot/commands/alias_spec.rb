RSpec.describe Rubot::Commands::Alias do
  before do
    ask 'ще ти викам пешо', channel: 'channel1'
    expect_answer Rubot::Response::OK, channel: 'channel1'
  end

  it 'remembers aliases' do
    ask 'пешо', channel: 'channel1', prefix: false
    expect_answer Rubot::Commands::Unknown::NO_COMMAND_RESPONSES, channel: 'channel1'
  end

  it 'does not respond to the same alias in a different channel' do
    ask 'пешо', channel: 'channel2', prefix: false
    expect_no_answer
  end
end
