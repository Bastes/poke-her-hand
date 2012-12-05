module Poker::Figure
  class Pair < Base
    def self.match cards, &block
      pair = (cards - [cards.last]).zip(cards - [cards.first]).
        detect { |(a,b)| a.versus(b) == 0 }
      return yield self.new(pair), cards - pair if pair
      yield nil, cards
    end

    def nominal_value
      1
    end
  end
end
