require 'csv'

module Rubot
  module Commands
    class SantaWishes < Rubot::Command
      command(/(дай|изпрати)( ми)? csv/) do |client, data, match|
        username = client.users[data.user].name

        unless Rubot.config[:admins].include? username
          client.say channel: data.channel, text: 'Съжалявам, но нямаш права :('
          next
        end

        csv = CSV.generate do |csv|
          csv << ['username', 'date', 'present']

          Rubot.memory[:wishes]&.each do |username, user_wishes|
            user_wishes.each do |wish|
              csv << [username, wish[:date], wish[:present]]
            end
          end
        end

        client.say channel: data.channel, text: "```#{csv}```"
      end
    end
  end
end
