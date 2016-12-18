module Rubot
  module Commands
    class LampControl < Rubot::Command
      ON_COMMANDS = [
        /(светни|пусни)( ми)?( ламп(ите|ата))?( (в|на) (?<room>.+))/i
      ].deep_freeze

      OFF_COMMANDS = [
        /((у|из|за)гаси|изключи|спри)( ми)?( ламп(ите|ата))?( (в|на) (?<room>.+))/i
      ].deep_freeze

      desc 'светни в <стая>', 'Светка лампите в стаята'
      commands ON_COMMANDS do |client, data, match|
        user = client.users[data.user]

        set_lamp_ids_for_room client, data, user, match[:room], true
      end

      desc 'изключи лампите в <стая>', 'Спира лампите в стаята'
      commands OFF_COMMANDS do |client, data, match|
        user = client.users[data.user]

        set_lamp_ids_for_room client, data, user, match[:room], false
      end

      def self.set_lamp_ids_for_room(client, data, user, room_name, switch_on)
        room_name = room_name.mb_chars.downcase.to_s
        room_light_ids = Rubot.config[:lamps][room_name]

        unless room_light_ids
          client.say channel: data.channel,
                     text: "Нямам данни за стаята #{room_name}. Провери дали името е написано правилно"
          return
        end

        lamp_updates = room_light_ids.map { |lamp_id| [lamp_id, switch_on] }.to_h
        LampControlService.set lamp_updates

        Rubot.logger.info "Lamp update request from #{user.profile.email}: #{lamp_updates.inspect}"

        client.say channel: data.channel,
                   text: Response.ok
      end

      # def self.set_lamps_for_email(client, data, email, switch_on)
      #   begin
      #     url = "#{Rubot.secrets[:humpty_url]}/api/employees/#{email}/switches"
      #     lamps = HttpService.get_json(url)
      #     lamp_updates = lamps.map { |lamp_id| [lamp_id, switch_on] }.to_h
      #
      #     Rubot.logger.info "Lamp update request from #{email}: #{lamp_updates.inspect}"
      #
      #     LampControlService.set lamp_updates
      #
      #     client.say channel: data.channel,
      #                text: Response.ok
      #   rescue HttpService::RemoteError => error
      #     Rubot.logger.error "Error getting lamps for #{email}", error
      #
      #     client.say channel: data.channel,
      #                text: 'Не знам кои са твоите лампи, няма те в Humpty с този email'
      #   end
      # end
    end
  end
end
