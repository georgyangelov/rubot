module Rubot
  module Commands
    class PingPong < Rubot::Command
      HELLO_RESPONSE = <<-TEXT.strip_heredoc
        Аз съм Астейският Дядо Коледа.
        Ако искаш и тази година да подариш и да получиш подарък, изпрати ми лично съобщение с текст “ще участвам”.

        Ще ти кажа какво още мога да правя, ако ми напишеш "подарък" или "чорап".
      TEXT

      desc 'Здравей', 'Поздрав. Трябва да сме учтиви.'
      command(/(здравей|здрасти|привет|хай|hi|йо|yo)/i) do |client, data, _|
        client.say channel: data.channel, text: HELLO_RESPONSE
      end

      command(/(к'?во|какво) става/i) do |client, data, _|
        client.say channel: data.channel, text: 'К\'во да става бе човек...'
      end

      HOW_ARE_YOU_RESPONSES = [
        'Винаги се чувствам прекрасно на Коледа!',
      ].deep_freeze

      desc 'Как си?', 'Трябва да се интересуваме от приятелите си.'
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

      desc 'Представи се!', ''
      command(/(представи се|кой си( ти)?)/i) do |client, data, _|
        client.say channel: data.channel, text: HELLO_RESPONSE
      end

      desc 'Кой те праща?', ''
      command(/кой си( ти)?|кой те (из)?праща/i) do |client, data, _|
        client.say channel: data.channel, text: 'Коледния отряд'
      end

      desc 'Кой те сътвори?', ''
      command(/кой те сътвори/i) do |client, data, _|
        client.say channel: data.channel, text: ':shushi: + :gangelov:'
      end

      desc 'Правила', ''
      command(/правила/i) do |client, data, _|
        text = <<-TEXT.strip_heredoc
        Бъдете послушни!
        Тази година моята задача е само да направя списък с всички послушни астейци, които искат да подарят и получат подарък.
        Не са ме програмирали да приемам желания за конкретни подаръци.
        За повече подробнoсти, обърнете се към Коледния отряд. Xo Xo Xo
        TEXT

        client.say channel: data.channel, text: text
      end

      command(/кажи нещо/i) do |client, data, _|
        client.say channel: data.channel, text: 'нещо'
      end

      JOKES = [
        'Скъпи дядо Коледа, тази година искам да ми подариш „Гражданска Отговорност“!',

        <<-JOKE.strip_heredoc,
          Какво пише в писмото на Лили Иванова до Дядо Коледа?
          – Ей, малкия да не ме забравиш за Коледа?
        JOKE

        <<-JOKE.strip_heredoc,
          Няколко признака, че Коледа наближава:
          - Отиваш си на село
          - Концертът на Веско Маринов!
          - Сериите на „Сам вкъщи“ по всички телевизии по няколко пъти
          - Ракията вече е ОК да се пие и топла
        JOKE

        <<-JOKE.strip_heredoc,
          В навечерието на Коледа мъж се клатушка по улицата, носейки елхичка.
          Една възрастна дама го вижда и с изумление казва:
          - Как не ви е срам по Коледа да се напивате, а да не стоите при семейството си?
          - И на мен ми се иска да се прибера, но не знам как да се измъкна от тази гора!
        JOKE

        <<-JOKE.strip_heredoc,
          Скъпи Дядо Коледа, искам хронично здраве, прогресивно щастие, рецидивиращ успех,
          хипертонична заплата и вечно бременно портмоне без опасност от аборт!
        JOKE

        <<-JOKE.strip_heredoc,
          Скъпи Дядо Коледа, искам хронично здраве, прогресивно щастие, рецидивиращ успех,
          хипертонична заплата и вечно бременно портмоне без опасност от аборт!
        JOKE

        <<-JOKE.strip_heredoc,
          На Коледа всички стават по-добри, освен българските футболисти.
        JOKE

        <<-JOKE.strip_heredoc,
          1ви януари. Бележка:
          Честита Нова година!

          PS.0. Зелевият сок е в хладилника
          PS.1. Хладилникът е в кухнята...

          Видял бележката :drunkdeyan: и се чуди:
          Добре де, а кухнята къде е!?
        JOKE

        <<-JOKE.strip_heredoc,
          Пътуваш с колата и поддържаш постоянна скорост.
          От лявата ти страна – пропаст.
          От дясната ти страна кара огромна пожарна кола и поддържа същата скорост като теб.
          Пред теб галопира прасе, което е голямо, колкото колата ти и не можеш да го изпревариш.
          Зад теб лети ниско хеликоптер.
          Прасето и хеликоптерът карат със същата скорост като теб!

          Какво ще предприемеш, за да излезеш от ситуацията невредим?

          Слизаш веднага от детската въртележка и спираш да пиеш греяно вино!!!
        JOKE
      ].deep_freeze

      desc 'Кажи ми виц', ''
      command(/кажи( ми)?( друга?)? (шега|виц|смешка)/i) do |client, data, _|
        client.say channel: data.channel, text: JOKES.sample
      end
    end
  end
end
