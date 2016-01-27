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
        'отивам си',
      ].deep_freeze

      LEAVING_REGEXP = /\b(#{LEAVING_MESSAGES.join('|')})\b/i.freeze

      listen_for LEAVING_REGEXP do |client, data, match|
        next if match[0] =~ /дейли/

        client.say channel: data.channel,
                   text: 'А ти кога дойде? :clock3:'
      end
    end
  end
end
