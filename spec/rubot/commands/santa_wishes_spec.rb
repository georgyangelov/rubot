RSpec.describe Rubot::Commands::SantaWishes do
  it 'accepts wishes' do
    i_am 'gangelov'
    ask 'пожелавам си чорапи'
    expect_answer 'Желанието ти е прието!'

    user_wish = Rubot.memory[:wishes]['gangelov'].first
    expect(user_wish[:present]).to eq 'чорапи'
    expect(user_wish[:date]).to be_present
  end

  it 'accepts multiple wishes' do
    i_am 'gangelov'

    ask 'пожелавам си чорапи'
    expect_answer 'Желанието ти е прието!'

    ask 'пожелавам си пари'
    expect_answer 'Желанието ти е прието!'

    first_wish = Rubot.memory[:wishes]['gangelov'].first
    expect(first_wish[:present]).to eq 'чорапи'
    expect(first_wish[:date]).to be_present

    second_wish = Rubot.memory[:wishes]['gangelov'].second
    expect(second_wish[:present]).to eq 'пари'
    expect(second_wish[:date]).to be_present
  end

  it 'accepts wishes from multiple people' do
    i_am 'gangelov'
    ask 'пожелавам си чорапи'
    expect_answer 'Желанието ти е прието!'

    i_am 'joro'
    ask 'пожелавам си пари'
    expect_answer 'Желанието ти е прието!'

    gangelov_wishes = Rubot.memory[:wishes]['gangelov']
    expect(gangelov_wishes.size).to eq 1
    expect(gangelov_wishes.first[:present]).to eq 'чорапи'
    expect(gangelov_wishes.first[:date]).to be_present

    joro_wishes = Rubot.memory[:wishes]['joro']
    expect(joro_wishes.size).to eq 1
    expect(joro_wishes.first[:present]).to eq 'пари'
    expect(joro_wishes.first[:date]).to be_present
  end
end
