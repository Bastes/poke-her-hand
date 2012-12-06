module Poker::Figure
  class Pair < Base
    def self.match cards, &block
      paired = (cards - [cards.last]).zip(cards - [cards.first]).
        select { |(a,b)| a.versus(b) == 0 }.
        flatten.uniq
      return yield nil, cards if paired.empty?
      yield self.new(paired), cards - paired
    end

    def nominal_value
      @cards.length / 2
    end
  end
end
