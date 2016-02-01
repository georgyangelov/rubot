RSpec.describe Rubot::Commands::PingPong do
  it 'can introduce itself' do
    ask 'представи се'
    expect_answer Rubot::Commands::PingPong::INTRODUCE_YOURSELF_RESPONSE, 'бот и боте'
  end

  it 'can say hi' do
    ask 'здравей'
    expect_answer Rubot::Commands::PingPong::HELLO_RESPONSES
  end

  it 'can say what\'s up' do
    ask 'кво става'
    expect_answer 'К\'во да става бе човек...'
  end

  it 'can respond to "What are you doing"' do
    ask 'какво правиш?'
    expect_answer Rubot::Commands::PingPong::WHAT_ARE_YOU_DOING_RESPONSES
  end

  it 'can say something' do
    ask 'кажи нещо'
    expect_answer 'нещо'
  end
end
