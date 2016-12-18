module CommandHelpers
  def stub_aliases
    Rubot.config[:aliases] = ['бот', 'боте']
  end

  def stub_user
    i_am 'user'
  end

  def i_am(username, email = 'gmail@gangelov.net')
    @user = double(name: username, profile: double(email: email))
  end

  def tell(command, channel: 'channel', **options)
    ask command, channel: channel, **options
    expect_ok_answer channel: channel
  end

  def ask(command, channel: 'channel', prefix: true)
    client = Rubot::Bot.instance.send(:client)

    @message = nil
    allow(client).to receive(:message).once do |channel:, text:|
      @message = [channel, text]
    end

    allow(client).to receive(:users).and_return({@user.name => @user})
    allow(client).to receive(:channels).and_return({channel => channel})

    command = "боте, #{command}" if prefix

    Rubot::Bot.instance.send(:message, client, text: command, channel: channel, user: @user.name)
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

  c.before(:each) do
    stub_aliases
    stub_user
  end
end
