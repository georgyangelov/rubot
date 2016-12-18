module Rubot
  module Commands
    class BeerMeter < Rubot::Command
      BEER_STATUS_COMMAND = /има ли бир(а|и)( в хладилника)?/i
      VODKA_STATUS_COMMAND = /има ли (водка|кола|мента|(твърд )?алкохол)( в хладилника)?/i

      BEER_SCALE = {
        'Няма бира. Ходи да купиш.'    => 150,
        'Има малко бира. Граби бързо.' => 800,
        'Има бира.'                    => 910,
        'Има много бира.'              => 2000,
      }.freeze

      VODKA_SCALE = {
        'Няма водка.'                     => 150,
        'Има малко водка. Крийте я!'      => 600,
        'Има достатъчно водка.'           => 850,
        'Някой е сложил диня на сензора!' => 2000,
      }.freeze

      desc 'има ли бира', 'Казва дали има бира'
      command BEER_STATUS_COMMAND do |client, data, _|
        user = client.users[data.user]

        Rubot.logger.info "Beer status request from #{user.profile.email}"

        send_response client, data, 'left', BEER_SCALE
      end

      desc 'има ли водка', 'Казва дали има водка'
      command VODKA_STATUS_COMMAND do |client, data, _|
        user = client.users[data.user]

        Rubot.logger.info "Vodka status request from #{user.profile.email}"

        send_response client, data, 'right', VODKA_SCALE
      end

      def self.send_response(client, data, sensor, scale)
        sensors  = HttpService.get_json("#{Rubot.secrets[:beer_mcu_url]}/status")
        response = response_for_sensor_value(scale, sensors[sensor])

        client.say channel: data.channel, text: response
      rescue HttpService::RemoteError => error
        Rubot.logger.error 'Error getting sensor values', error

        client.say channel: data.channel, text: 'Няма връзка с хладилника!'
      end

      def self.response_for_sensor_value(scale, reading)
        scale.find { |response, value| reading <= value }.first
      end
    end
  end
end
