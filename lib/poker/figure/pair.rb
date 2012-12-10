module Poker::Figure
  class Pair < Base
    def self.match cards, &block
      paired = (cards - [cards.last]).zip(cards - [cards.first]).
        select { |(a,b)| a.versus(b) == 0 }.
        flatten.uniq
      yield self.new(paired), Nothing.new(cards - paired) unless paired.empty?
    end

    def nominal_value
      @cards.length / 2
    end
  end
end
