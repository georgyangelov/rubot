module Rubot
  module Response
    extend self

    OK = [
      'Окей',
      'Както кажеш',
      'Ти си шефа',
      'Става',
      'Добре',
    ].deep_freeze

    INPUT_ERRORS = [
      'Ти луд ли си? %s',
      'Кво ти става? %s',
      'Айде стига си игра и работѝ. %s',
      '%s Да му се не види!',
      '%s Я дай пак.',
      'Я дай пак, че нещо не разбрах. %s',
      '%s И ся к\'во прайм?',
      '%s Дейба!',
    ].deep_freeze

    ERROR = [
      'Нещо се спекох. `%s`',
      'Стана тя една... `%s`',
      'Счупѝх са нещо, муцка. `%s`',
      'Сбъгясах се. На ти съобщение: `%s`',
    ].deep_freeze

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
