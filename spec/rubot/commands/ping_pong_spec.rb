RSpec.describe Rubot::Commands::PingPong do
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
