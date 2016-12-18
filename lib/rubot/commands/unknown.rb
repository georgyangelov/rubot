module Rubot
  module Commands
    class Unknown < Rubot::Command
      NO_COMMAND = /\s*/i.freeze
      ARE_YOU_HERE_COMMAND = /(тука? ли си|тук\?)/i.freeze
      UNKNOWN_COMMAND = /(?<command>.*)/i.freeze

      NO_COMMAND_RESPONSES = [
        'Тук съм.',
        'Тук съм, споко.',
        'Дааа?',
        'Искаш ли нещо?',
        'Слушам.',
        'Слушам те.',
        'Старшина Рубов се явява по служба!',
        'ZZZzzzzzz... А? Кой смее да ме буди от вечния ми сън?',
      ].deep_freeze

      UNKNOWN_COMMAND_RESPONSES = [
        'Какво трябва да значи `%s`?',
        'Не го разбирам това твоето `%s`',
        'Не мога да те разбера. Това `%s` на какъв език е?',
        'Не мога да те разбера, честно. Какво е `%s`?',
        'Извинявай, но не мога да парсна `%s` :(',
        'Какви са тези неща дето ми ги пращаш? `%s` ще ми вика...',
        'Уважаеми господине/госпожо. Моля Ви да извините невежеството ми, но аз съм само един ' \
          'беден бот и не разбирам какво ми казвате. `%s` за мен не означава нищо.',
      ].deep_freeze

      command NO_COMMAND do |client, data, _|
        client.say channel: data.channel,
                   text: NO_COMMAND_RESPONSES.sample
      end

      command ARE_YOU_HERE_COMMAND do |client, data, _|
        client.say channel: data.channel,
                   text: NO_COMMAND_RESPONSES.sample
      end

      command UNKNOWN_COMMAND do |client, data, match|
        client.say channel: data.channel,
                   text: UNKNOWN_COMMAND_RESPONSES.sample % match[:command]
      end
    end
  end
end
