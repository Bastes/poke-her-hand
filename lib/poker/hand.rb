module Poker
  class Hand
    VALUES = (2..10).
      inject({}) { |r, i| r.tap { r["#{i}"] = i } }.
      merge({ 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 })
    VALUE = /\A([2-9JQKA]|10)/

    def initialize(cards)
      @cards = cards.split(/ /).
        sort { |a, b| [VALUES[a[VALUE]], a] <=> [VALUES[b[VALUE]], b] }.
        join ' '
    end

    def to_s
      @cards
    end
  end
end
