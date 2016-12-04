module Rubot
  module Commands
    class Unknown < Rubot::Command
      NO_COMMAND = /\s*/i.freeze
      ARE_YOU_HERE_COMMAND = /(тука? ли си|тук\?)/i.freeze
      UNKNOWN_COMMAND = /(?<command>.*)/i.freeze

      NO_COMMAND_RESPONSES = [
        'Дааа?',
        'Искаш ли нещо?',
        'Слушам.',
        'Слушам те.',
        'Хо-хо-хо!',
      ].deep_freeze

      UNKNOWN_COMMAND_RESPONSES = [
        'Не разбирам какво значи `%s`',
        'Извинявай, но не мога да парсна `%s` :(',
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
