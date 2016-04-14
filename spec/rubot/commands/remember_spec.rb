RSpec.describe Rubot::Commands::Remember do
  it 'remembers items as a list' do
    tell 'запомни, че Пешо, Иван и Гошо са девове'
    ask 'покажи девовете'

    expect_answer 'Пешо, Иван и Гошо'
  end

  it 'remembers the list only for the current channel' do
    tell 'запомни, че Пешо и Гошо са девове', channel: 'channel1'
    ask 'покажи девовете', channel: 'channel2'

    expect_answer Rubot::Response::INPUT_ERRORS, "Няма списък 'девовете'.",
                  channel: 'channel2'
  end

  describe 'adding items to lists' do
    before do
      tell 'запомни, че Пешо и Иван са девове'
    end

    it 'can add a single item' do
      tell 'Гошо е дев'
      ask 'покажи девовете'

      expect_answer 'Пешо, Иван и Гошо'
    end

    it 'can add multiple items' do
      tell 'Гошо и Радо са девове'
      ask 'покажи девовете'

      expect_answer 'Пешо, Иван, Гошо и Радо'
    end

    it 'can add items using the long form' do
      tell 'добави Гошо и Радо към девовете'
      ask 'покажи девовете'

      expect_answer 'Пешо, Иван, Гошо и Радо'
    end
  end

  it 'can add items to a nonexisting list' do
    tell 'Иванчо и Марийка са лоши'

    ask 'покажи лошите'
    expect_answer 'Иванчо и Марийка'
  end

  describe 'removing items from lists' do
    before do
      tell 'запомни, че Пешо и Иван са девове'
    end

    it 'can remove a single item' do
      tell 'Пешо не е дев'
      ask 'покажи девовете'

      expect_answer 'Иван'
    end

    it 'can remove multiple items' do
      tell 'Иван и Пешо не са девове'
      ask 'покажи девовете'

      expect_answer Rubot::Response::INPUT_ERRORS, 'Няма никой от \'девовете\'.'
    end

    it 'can remove items using the long form' do
      tell 'махни Пешо от девовете'
      ask 'покажи девовете'

      expect_answer 'Иван'
    end
  end
end
