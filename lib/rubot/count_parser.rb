module Rubot
  module CountParser
    NUMBERS = {
      /\A(нула)\z/i            => 0,
      /\A(един|едно|една)\z/i  => 1,
      /\A(два|две|двама)\z/i   => 2,
      /\A(три|трима)\z/i       => 3,
      /\A(четири|четирима)\z/i => 4,
      /\A(пет|петима)\z/i      => 5,
      /\A(шест|шестима)\z/i    => 6,
      /\A(седем|седмина)\z/i   => 7,
      /\A(осем|осмина)\z/i     => 8,
      /\A(девет|деветима)\z/i  => 9,
      /\A(десет|десетима)\z/i  => 10,
    }.freeze

    def self.parse(string)
      return string.to_i if string =~ /\A[0-9]+\z/

      number_pair = NUMBERS.find { |matcher, _| string =~ matcher }

      return number_pair.last if number_pair

      nil
    end
  end
end
