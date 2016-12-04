module Rubot
  module Commands
    class SantaWishes < Rubot::Command
      MAKE_A_WISH_PATTERNS = [
        /пожелавам си/,
        /искам/,
        /донеси ми/,
        /подари ми/,
      ].map { |pattern| /#{pattern} (?<present>.+)/i }.deep_freeze

      WISH_RESPONSES = [
        'Ще се постарая да изпълня желанието ти :)',
        'Желанието ти е прието! :)',
        'Веднага поръчвам на джуджетата!',
        'Много интересно! Поръчвам на джуджетата :)',
        'Интересно! Няма да те разочаровам :)',
      ].deep_freeze

      # TODO: Descriptions
      desc 'пожелавам си ...', ''
      commands MAKE_A_WISH_PATTERNS do |client, data, match|
        username = client.users[data.user].name

        wishes      = Rubot.memory[:wishes] ||= {}
        user_wishes = wishes[username]      ||= []
        user_wishes << {present: match[:present], date: Time.zone.now.iso8601}
        Rubot.memory.save

        client.say channel: data.channel, text: WISH_RESPONSES.sample
      end

      # TODO: Descriptions
      desc 'изненадай ме', 'Остави на Дядо Коледа да избере подаръка'
      command(/изненадай ме/) do |client, data, match|
        username = client.users[data.user].name

        wishes      = Rubot.memory[:wishes] ||= {}
        user_wishes = wishes[username]      ||= []
        user_wishes << {present: 'изненада', date: Time.zone.now.iso8601}
        Rubot.memory.save

        client.say channel: data.channel, text: 'Очаква те приятна изненада :)'
      end
    end
  end
end
