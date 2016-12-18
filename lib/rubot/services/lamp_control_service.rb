module Rubot
  module LampControlService
    extend self

    def self.set(updates)
      MQTT::Client.connect(Rubot.secrets[:mqtt].symbolize_keys) do |c|
        c.publish('shadow/set', updates.to_json)
      end
    end
  end
end
