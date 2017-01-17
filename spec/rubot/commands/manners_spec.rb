RSpec.describe Rubot::Commands::Manners do
  it 'shows good manners' do
    ask 'мерси'

    expect_answer 'Но моля ви се, удоволствието беше мое!'
  end
end
