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

      command(/(здравей|здрасти|привет|хай|hi|йо|yo)/) do |client, data, _|
        client.say channel: data.channel, text: HELLO_RESPONSES.sample
      end

      command(/(к'?во става|какво става)/) do |client, data, _|
        client.say channel: data.channel, text: 'К\'во да става бе човек...'
      end

      HOW_ARE_YOU_RESPONSES = [
        'Аз съм бот бе човек, как може да съм.',
        'Горе-долу...',
        'Бивам',
        'Добре съм, ям рам и спя по цял ден. Райски живот си живея направо.',
      ].deep_freeze

      command(/как си/) do |client, data, _|
        client.say channel: data.channel, text: HOW_ARE_YOU_RESPONSES.sample
      end

      INTRODUCE_YOURSELF_RESPONSE = 'Здравейте ^_^ Аз съм Рубот. Отговарям на всякакви ' \
                                    'команди (стига да ме програмирате).'.freeze

      command(/(представи се|кой си( ти)?)/) do |client, data, _|
        client.say channel: data.channel,
                   text: INTRODUCE_YOURSELF_RESPONSE
      end

      command(/кажи нещо/) do |client, data, _|
        client.say channel: data.channel, text: 'нещо'
      end
    end
  end
end
