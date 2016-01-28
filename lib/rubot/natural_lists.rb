module Rubot
  module NaturalLists
    def self.parse(string)
      string.split(/,|\bи\b/i).map(&:strip).compact
    end

    def self.construct(items)
      if items.size > 1
        "#{items.take(items.size - 1).join(', ')} и #{items.last}"
      else
        items.last
      end
    end
  end
end
