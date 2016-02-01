module CommandHelpers
  def stub_aliases
    Rubot::CONFIG['aliases'] = ['бот', 'боте']
  end

  def ask(command, channel: 'channel', prefix: true)
    client = Rubot::Bot.instance.send(:client)

    @message = nil
    allow(client).to receive(:message).once do |channel:, text:|
      @message = [channel, text]
    end

    command = "боте, #{command}" if prefix

    Rubot::Bot.instance.send(:message, client, text: command, channel: channel, user: 'user')
  end

  def expect_answer(expected_response, params = '', channel: 'channel')
    client = Rubot::Bot.instance.send(:client)

    expect(@message).to be

    if expected_response.kind_of? Array
      expect(@message.first).to eq channel
      expect(expected_response.map { |m| m % params }).to include(@message.last)
    else
      expect(@message.first).to eq channel
      expect(@message.last).to eq(expected_response % params)
    end
  end

  def expect_no_answer
    expect(@message).to be nil
  end

  def expect_ok_answer(*args)
    expect_answer(Rubot::Response::OK, *args)
  end
end

RSpec.configure do |c|
  c.include CommandHelpers

  c.before(:each) { stub_aliases }
end
