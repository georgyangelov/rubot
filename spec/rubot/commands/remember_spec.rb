RSpec.describe Rubot::Commands::Remember do
  it 'remembers items as a list' do
    ask 'запомни, че Пешо, Иван и Гошо са девове'
    expect_ok_answer

    ask 'покажи девовете'
    expect_answer 'Пешо, Иван и Гошо'
  end

  it 'remembers the list only for the current channel' do
    ask 'запомни, че Пешо и Гошо са девове', channel: 'channel1'
    expect_ok_answer channel: 'channel1'

    ask 'покажи девовете', channel: 'channel2'
    expect_answer Rubot::Response::INPUT_ERRORS, "Няма списък 'девовете'.",
                  channel: 'channel2'
  end
end
