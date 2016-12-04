module Rubot
  module Commands
    class PingPong < Rubot::Command
      HELLO_RESPONSES = [
        'Хо-хо-хо!'
      ].deep_freeze

      desc 'Здравей', 'Поздрав. Трябва да сме учтиви.'
      command(/(здравей|здрасти|привет|хай|hi|йо|yo)/i) do |client, data, _|
        client.say channel: data.channel, text: HELLO_RESPONSES.sample
      end

      command(/(к'?во|какво) става/i) do |client, data, _|
        client.say channel: data.channel, text: 'К\'во да става бе човек...'
      end

      HOW_ARE_YOU_RESPONSES = [
        'Винаги се чувствам прекрасно на Коледа!',
      ].deep_freeze

      desc 'как си', 'Трябва да се интересуваме от приятелите си.'
      command(/Как си?/i) do |client, data, _|
        client.say channel: data.channel, text: HOW_ARE_YOU_RESPONSES.sample
      end

      WHAT_ARE_YOU_DOING_RESPONSES = [
        'Разнасям подаръци!',
      ].deep_freeze

      desc 'Какво правиш?', ''
      command(/(к'?во|какво) правиш/i) do |client, data, _|
        client.say channel: data.channel, text: WHAT_ARE_YOU_DOING_RESPONSES.sample
      end

      INTRODUCE_YOURSELF_RESPONSE = 'Дядо Коледа Хо-хо-хо!'

      desc 'Кой си ти?', ''
      command(/(представи се|кой си( ти)?)/i) do |client, data, _|
        names = Rubot::Bot.names(data.channel)
        natural_names = Rubot::NaturalLists.construct(names)

        client.say channel: data.channel,
                   text: INTRODUCE_YOURSELF_RESPONSE % natural_names
      end

      desc 'Кой те праща?', ''
      command(/кой си( ти)?|кой те (из)?праща/i) do |client, data, _|
        client.say channel: data.channel, text: 'Коледния отряд'
      end

      command(/кажи нещо/i) do |client, data, _|
        client.say channel: data.channel, text: 'нещо'
      end

      JOKES = [
        'Еврейският дядо Коледа: - Здравейте, дечица... Купете подаръци!',

        <<-JOKE.strip_heredoc,
          Дете на програмист пита баща си:
          - Тате, Дядо Коледа как побира в чувала подаръците за всички деца по света?
          - С Win Zip, моето момче.
        JOKE

        <<-JOKE.strip_heredoc,
          Заглавие в македонските вестници:
          - Прелитайки над Македония за празниците дядо Коледа макар и за малко отново ще си бъде вкъщи.
        JOKE

        <<-JOKE.strip_heredoc,
          В навечерието на Коледа мъж се клатушка по улицата, носейки елхичка.
          Една възрастна дама го вижда и с изумление казва:
          - Как не ви е срам по Коледа да се напивате, а да не стоите при семейството си?
          - И на мен ми се иска да се прибера, но не знам как да се измъкна от тази гора!
        JOKE

        <<-JOKE.strip_heredoc,
          Как се нарича човек, който мрази старци? Дядо Мраз.
        JOKE
      ].deep_freeze

      desc 'Кажи ми виц', ''
      command(/кажи( ми)?( друга?)? (шега|виц|смешка)/i) do |client, data, _|
        client.say channel: data.channel, text: JOKES.sample
      end
    end
  end
end
