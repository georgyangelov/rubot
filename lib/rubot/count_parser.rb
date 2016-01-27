module Rubot
  module CountParser
    NUMBERS = {
      /\A(нула)\z/            => 0,
      /\A(един|едно|една)\z/  => 1,
      /\A(два|две|двама)\z/   => 2,
      /\A(три|трима)\z/       => 3,
      /\A(четири|четирима)\z/ => 4,
      /\A(пет|петима)\z/      => 5,
      /\A(шест|шестима)\z/    => 6,
      /\A(седем|седмина)\z/   => 7,
      /\A(осем|осмина)\z/     => 8,
      /\A(девет|деветима)\z/  => 9,
      /\A(десет|десетима)\z/  => 10,
    }.freeze

    def self.parse(string)
      return string.to_i if string =~ /\A[0-9]+\z/

      number_pair = NUMBERS.find { |matcher, _| string =~ matcher }

      return number_pair.last if number_pair

      nil
    end
  end
end
