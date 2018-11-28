RSpec.describe Rubot::Commands::SantaWishes do
  shared_examples_for 'a request' do |request|
    it 'accepts a request' do
      i_am 'gangelov'
      ask request
      expect_answer Rubot::Commands::SantaWishes::WISH_RESPONSES

      user_wish = Rubot.memory[:wishes]['gangelov'].first
      expect(user_wish[:date]).to be_present
    end
  end

  it_behaves_like 'a request', 'Ще участвам'
  it_behaves_like 'a request', 'ще участвам'
  it_behaves_like 'a request', 'участвам'
  it_behaves_like 'a request', 'Вътре съм'
  it_behaves_like 'a request', 'Искам да подарявам'
  it_behaves_like 'a request', 'Записвам се'

  it 'accepts multiple requests' do
    i_am 'gangelov'

    ask 'Ще участвам'
    expect_answer Rubot::Commands::SantaWishes::WISH_RESPONSES

    ask 'Ще участвам'
    expect_answer Rubot::Commands::SantaWishes::WISH_RESPONSES

    first_wish = Rubot.memory[:wishes]['gangelov'].first
    expect(first_wish[:date]).to be_present

    second_wish = Rubot.memory[:wishes]['gangelov'].second
    expect(second_wish[:date]).to be_present
  end

  it 'accepts wishes from multiple people' do
    i_am 'gangelov'
    ask 'Ще участвам'
    expect_answer Rubot::Commands::SantaWishes::WISH_RESPONSES

    i_am 'joro'
    ask 'Ще участвам'
    expect_answer Rubot::Commands::SantaWishes::WISH_RESPONSES

    gangelov_wishes = Rubot.memory[:wishes]['gangelov']
    expect(gangelov_wishes.size).to eq 1
    expect(gangelov_wishes.first[:date]).to be_present

    joro_wishes = Rubot.memory[:wishes]['joro']
    expect(joro_wishes.size).to eq 1
    expect(joro_wishes.first[:date]).to be_present
  end
end
