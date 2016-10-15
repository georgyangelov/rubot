module Rubot
  module Commands
    class BeerMeter < Rubot::Command
      BEER_STATUS_COMMANDS = [
        /има ли някой в (кенеф(а|ът)|тоалетната)/i,
        /има ли някой на трон(а|ът)/i,
        /свобод(ен|на|но) ли е( в)? (кенефа|тоалетната|офис(а|ът))/i
      ].deep_freeze

      FREE_SENSOR_VALUE = 200

      desc 'свободна ли е тоалетната', 'Казва дали има някой на трона'
      commands BEER_STATUS_COMMANDS do |client, data, _|
        user = client.users[data.user]

        Rubot.logger.info "Toilet status request from #{user.profile.email}"

        send_toilet_response client, data
      end

      def self.send_toilet_response(client, data)
        sensors = HttpRequests.get_json("#{Rubot.secrets[:optimus_url]}/status")
        is_free = sensors['distance'] < FREE_SENSOR_VALUE

        client.say channel: data.channel, text: is_free ? 'Свободно е' : 'Заето е, стискай'
      rescue HttpRequests::RemoteError => error
        Rubot.logger.error 'Error getting throne sensor value', error

        client.say channel: data.channel, text: 'Няма връзка с кенефа!'
      end
    end
  end
end
