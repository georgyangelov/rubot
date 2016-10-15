module Rubot
  module Commands
    class PingPong < Rubot::Command
      ON_COMMANDS = [
        /светни|светни ми|светни( ми)? ламп(ите|ата)/i,
        /пусни( ми)? ламп(ите|ата)/i
      ].deep_freeze

      OFF_COMMANDS = [
        /(у|из)гаси|(у|из)гаси ми|(у|из)гаси( ми)? ламп(ите|ата)/i,
        /спри( ми)? ламп(ите|ата)/i
      ].deep_freeze

      desc 'светни ми лампите', 'Светка лампи'
      commands ON_COMMANDS do |client, data, _|
        user = client.users[data.user]

        set_lamps_for_email client, data, user.profile.email, true
      end

      desc 'спри ми лампите', 'Светка лампи'
      commands OFF_COMMANDS do |client, data, _|
        user = client.users[data.user]

        set_lamps_for_email client, data, user.profile.email, false
      end

      def self.set_lamps(updates)
        MQTT::Client.connect(Rubot.secrets[:mqtt].symbolize_keys) do |c|
          c.publish('shadow/set', updates.to_json)
        end
      end

      def self.set_lamps_for_email(client, data, email, switch_on)
        begin
          url = "#{Rubot.secrets[:humpty_url]}/api/employees/#{email}/switches"
          lamps = HttpRequests.get_json(url)
          lamp_updates = lamps.map { |lamp_id| [lamp_id, switch_on] }.to_h

          Rubot.logger.info "Lamp update request from #{email}: #{lamp_updates.inspect}"

          set_lamps lamp_updates

          client.say channel: data.channel,
                     text: Response.ok
        rescue HttpRequests::RemoteError => error
          Rubot.logger.error "Error getting lamps for #{email}", error

          client.say channel: data.channel,
                     text: 'Не знам кои са твоите лампи, няма те в Humpty с този email'
        end
      end
    end
  end
end
