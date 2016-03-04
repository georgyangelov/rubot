module Rubot
  module Listeners
    class WhenDidYouCome < Listener
      LEAVING_MESSAGES = [
        'ще тръгвам',
        'ще вървя',
        'тръгвам си',
        'си тръгвам',
        'си вървя',
        'се прибирам',
        'отивам си',
        'прибирам се',
        'се прибирам',
        'си отивам',
      ].deep_freeze

      LEAVING_REGEXP = /\b(#{LEAVING_MESSAGES.join('|')})\b/i.freeze

      # Disabled for now...
      # listen_for LEAVING_REGEXP do |client, data, match|
      #   next if match.string =~ /\bдейли\b/i
      #
      #   client.say channel: data.channel,
      #              text: 'А ти кога дойде? :clock3:'
      # end
    end
  end
end
