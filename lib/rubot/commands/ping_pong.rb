module Rubot
  module Commands
    class PingPong < Rubot::Command
      HELLO_RESPONSES = [
        'Здравей ^_^',
        'Здрасти ^_^',
        'Привет ^_^',
        'К\'во става',
        'Йо',
        'Хай ^_^',
      ].deep_freeze

      command(/(здравей|здрасти|привет|хай|hi|йо|yo|к'?во става)/) do |client, data, _|
        client.say channel: data.channel, text: HELLO_RESPONSES.sample
      end

      INTRODUCE_YOURSELF_RESPONSE = 'Здравейте ^_^ Аз съм Рубот. Отговарям на всякакви ' \
                                    'команди, стига да ме програмирате.'.freeze

      command(/(представи се|кой си( ти)?)/) do |client, data, _|
        client.say channel: data.channel,
                   text: INTRODUCE_YOURSELF_RESPONSE
      end
    end
  end
end
