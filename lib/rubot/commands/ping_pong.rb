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

      desc 'здравей', 'Поздрав. Трябва да сме учтиви.'
      command(/(здравей|здрасти|привет|хай|hi|йо|yo)/) do |client, data, _|
        client.say channel: data.channel, text: HELLO_RESPONSES.sample
      end

      command(/(к'?во|какво) става/) do |client, data, _|
        client.say channel: data.channel, text: 'К\'во да става бе човек...'
      end

      HOW_ARE_YOU_RESPONSES = [
        'Аз съм бот бе човек, как може да съм.',
        'Горе-долу...',
        'Бивам',
        'Добре съм, ям рам и спя по цял ден. Райски живот си живея направо.',
        'А ти нямаш ли си работа?',
      ].deep_freeze

      desc 'как си', 'Трябва да се интересуваме от приятелите си.'
      command(/как си/) do |client, data, _|
        client.say channel: data.channel, text: HOW_ARE_YOU_RESPONSES.sample
      end

      WHAT_ARE_YOU_DOING_RESPONSES = [
        'Аз съм бот бе човек, какво може да правя.',
        'Бича айляк',
        'Ям рам. Остави ме намира',
        'Въртя си харда за кеф',
        'Пържа си яйца на процесора',
        'Гледам клипчета в YouTube',
        'А ти нямаш ли си работа?',
        'Чакам някой да се сети да ми даде работа',
      ].deep_freeze

      desc 'какво правиш', 'Какъв ли е ботския живот?'
      command(/(к'?во|какво) правиш/) do |client, data, _|
        client.say channel: data.channel, text: WHAT_ARE_YOU_DOING_RESPONSES.sample
      end

      INTRODUCE_YOURSELF_RESPONSE = 'Здравейте ^_^ Аз съм Рубот, ' \
        'но може да ми викате %s. ' \
        'За повече информация ме питайте за помощ (`<име>, хелп?`).'.freeze

      desc 'представи се', ''
      command(/(представи се|кой си( ти)?)/) do |client, data, _|
        names = Rubot::Bot.names(data.channel)
        natural_names = Rubot::NaturalLists.construct(names)

        client.say channel: data.channel,
                   text: INTRODUCE_YOURSELF_RESPONSE % natural_names
      end

      desc 'кажи нещо', 'Казва нещо.'
      command(/кажи нещо/) do |client, data, _|
        client.say channel: data.channel, text: 'нещо'
      end
    end
  end
end
