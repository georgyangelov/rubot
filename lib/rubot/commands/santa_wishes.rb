module Rubot
  module Commands
    class SantaWishes < Rubot::Command
      MAKE_A_WISH_PATTERNS = [
        /пожелавам си/i,
        /искам/i,
        /донеси ми/i,
        /подари ми/i,
      ].map { |pattern| /#{pattern} (?<present>.+)/i }.deep_freeze

      WISH_RESPONSES = [
        'Ще се постарая да изпълня желанието ти :)',
        'Желанието ти е прието! :)',
        'Веднага поръчвам на джуджетата!',
        'Много интересно! Поръчвам на джуджетата :)',
        'Интересно! Няма да те разочаровам :)',
      ].deep_freeze

      desc 'Пожелавам си <желание>', 'Пожелай си нещо :)'
      commands MAKE_A_WISH_PATTERNS do |client, data, match|
        username = client.users[data.user].name

        wishes      = Rubot.memory[:wishes] ||= {}
        user_wishes = wishes[username]      ||= []
        user_wishes << {present: match[:present], date: Time.zone.now.iso8601}
        Rubot.memory.save

        client.say channel: data.channel, text: WISH_RESPONSES.sample
      end

      desc 'Изненадай ме!', 'Остави на Дядо Коледа да избере подаръка'
      command(/изненадай ме/i) do |client, data, _|
        username = client.users[data.user].name

        wishes      = Rubot.memory[:wishes] ||= {}
        user_wishes = wishes[username]      ||= []
        user_wishes << {present: 'изненада', date: Time.zone.now.iso8601}
        Rubot.memory.save

        client.say channel: data.channel, text: 'Очаква те приятна изненада :)'
      end

      command(/не искам (нищо|подаръ(к|ци))/i) do |client, data|
        client.say channel: data.channel, text: '/giphy nothing', gif: 'nothing'
      end
    end
  end
end
