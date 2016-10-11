module Rubot
  module Commands
    class BeerMeter < Rubot::Command
      BEER_STATUS_COMMAND = /има ли бир(а|и)( в хладилника)?/i

      BEER_SCALE = {
        'Няма бира. Ходи да купиш.'    => 400,
        'Има малко бира. Граби бързо.' => 900,
        'Има бира.'                    => 915,
        'Има много бира.'              => 2000,
      }.freeze

      desc 'има ли бира', 'Казва дали има бира'
      command BEER_STATUS_COMMAND do |client, data, _|
        user = client.users[data.user]

        puts "Beer status request from #{user.profile.email}"

        send_beer_response client, data
      end

      def self.send_beer_response(client, data)
        sensors  = HttpRequests.get_json("#{Rubot::SECRETS['beer_mcu_url']}/status")
        response = beer_amount_for_sensor_value(sensors['left'], sensors['right'])

        client.say channel: data.channel, text: response
      rescue HttpRequests::RemoteError => error
        puts 'Error getting beer sensor values'
        p error

        client.say channel: data.channel, text: 'Няма връзка с хладилника!'
      end

      def self.beer_amount_for_sensor_value(left_value, _right_value)
        BEER_SCALE.find { |response, value| left_value <= value }.first
      end
    end
  end
end
