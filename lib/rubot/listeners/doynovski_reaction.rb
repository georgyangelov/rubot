module Rubot
  module Listeners
    class DoynovskiReaction < Listener
      pass_through

      listen_for /./ do |client, data, match|
        user = client.users[data.user]
        channel = client.channels[data.channel]

        next unless user or channel
        next unless CONFIG['reactions']
        next unless CONFIG['reactions'][channel.name]

        reactions = CONFIG['reactions'][channel.name][user.name]

        next unless reactions

        reactions.each do |emoji_name|
          client.web_client.reactions_add name: emoji_name,
                                          channel: data.channel,
                                          timestamp: data.ts
        end
      end
    end
  end
end
