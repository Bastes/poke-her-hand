module Poker::Figure
  class ThreeOfAKind < Base
    def self.match cards, &block
      three = cards[0,3].zip(cards[1,3], cards[2,3]).
        detect { |(a,b,c)| a.versus(b) == 0 && a.versus(c) == 0 }
      yield self.new(three), Nothing.new(cards - three) if three
    end

    def nominal_value
      3
    end
  end
end
