module Poker
  class Hand
    ACCEPTABLE = /\A(([2-9JQKA]|10)[CDHS])( ([2-9JQKA]|10)[CDHS]){4}\Z/
    VALUES = (2..10).
      inject({}) { |r, i| r.tap { r["#{i}"] = i } }.
      merge({ 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 })
    VALUE = /\A([2-9JQKA]|10)/

    def initialize(cards)
      acceptable! cards
      @cards = cards.split(/ /).sort { |a, b| [value(a), a] <=> [value(b), b] }
    end

    def to_s
      @cards.join ' '
    end

    def <=> challenger
      -challenger.challenge(@cards)
    end

    protected

    def challenge cards
      @cards.zip(cards).inject(0) { |r, (a, b)| (value(a) <=> value(b)).tap { |r| return r unless r== 0 } }
    end

    def acceptable! cards
      return true if cards =~ ACCEPTABLE
      raise ArgumentError.new("#{cards} is not a poker hand")
    end

    def value card
      VALUES[card[VALUE]]
    end
  end
end
