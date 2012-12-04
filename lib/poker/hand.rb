module Poker
  class Hand
    ACCEPTABLE = /\A(([2-9JQKA]|10)[CDHS])( ([2-9JQKA]|10)[CDHS]){4}\Z/
    VALUES = (2..10).
      inject({}) { |r, i| r.tap { r["#{i}"] = i } }.
      merge({ 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 })
    VALUE = /\A([2-9JQKA]|10)/

    def initialize(cards)
      raise ArgumentError.new("#{cards} is not a poker hand") unless cards =~ ACCEPTABLE
      @cards = cards.split(/ /).
        sort { |a, b| [VALUES[a[VALUE]], a] <=> [VALUES[b[VALUE]], b] }.
        join ' '
    end

    def to_s
      @cards
    end
  end
end
