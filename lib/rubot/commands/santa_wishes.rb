module Rubot
  module Commands
    class SantaWishes < Rubot::Command
      JOIN_IN_PATTERNS = [
        /ще участвам/i,
        /вътре съм/i,
        /искам да подарявам/i,
        /записвам се/i,
        /брой ме/i,
        /ще подарявам/i
      ].map { |pattern| /#{pattern}*/i }.deep_freeze

      WISH_RESPONSES = [
        'Ще се постарая да участваш :)',
        'Желанието ти е прието! :)',
        'Веднага те записвам! :)',
        'Дано си слушал тази година :)',
        'В играта си :)'
      ].deep_freeze

      ['ще участвам', 'брой ме', 'записвам се', 'искам да подарявам'].each do |s|
        desc s, ''
        commands JOIN_IN_PATTERNS do |client, data, match|
          username = client.users[data.user].name

          wishes      = Rubot.memory[:wishes] ||= {}
          user_wishes = wishes[username]      ||= []
          user_wishes << {date: Time.zone.now.iso8601}
          Rubot.memory.save

          client.say channel: data.channel, text: WISH_RESPONSES.sample
        end
      end
    end
  end
end
