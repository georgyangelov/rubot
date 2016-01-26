module Rubot
  module Response
    extend self

    OK = [
      'Окей',
      'Както кажеш',
      'Ти си шефа',
      'Става',
      'Добре',
    ].map(&:freeze).freeze

    INPUT_ERROR = [
      'Ти луд ли си? %s',
      'Кво ти става? %s',
      'Айде стига си игра и работѝ. %s',
      '%s Да му се не види!',
      '%s Я дай пак.',
      'Я дай пак, че нещо не разбрах. %s',
      '%s И ся к\'во прайм?'
    ].map(&:freeze).freeze

    ERROR = [
      'Нещо се спекох. `%s`',
      'Стана тя една... `%s`',
      'Счупѝх са нещо, муцка. `%s`',
      'Сбъгясах се. На ти съобщение: `%s`',
    ].map(&:freeze).freeze

    def ok
      OK.sample
    end

    def input_error(message)
      INPUT_ERRORS.sample % escape_backticks(message)
    end

    def error(message)
      ERROR.sample % escape_backticks(message)
    end

    private

    def escape_backticks(message)
      message.gsub('`', '\'')
    end
  end
end
