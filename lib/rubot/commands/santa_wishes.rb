module Rubot
  module Commands
    class SantaWishes < Rubot::Command
      MAKE_A_WISH_PATTERNS = [
        /пожелавам си/,
        /искам/,
        /донеси ми/,
        /подари ми/,
      ].map { |pattern| /#{pattern} (?<present>.+)/i }.deep_freeze

      # TODO: Descriptions
      desc 'пожелавам си ...', ''
      commands MAKE_A_WISH_PATTERNS do |client, data, match|
        username = client.users[data.user].name

        wishes      = Rubot.memory[:wishes] ||= {}
        user_wishes = wishes[username]      ||= []
        user_wishes << {present: match[:present], date: Time.zone.now.iso8601}
        Rubot.memory.save

        client.say channel: data.channel, text: 'Желанието ти е прието!'
      end
    end
  end
end
