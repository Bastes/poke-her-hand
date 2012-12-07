module Poker::Figure
  class FullHouse < Base
    def self.match cards, &block
      three = cards[0,3].zip(cards[1,3], cards[2,3]).
        detect { |(a,b,c)| a.versus(b) == 0 && a.versus(c) == 0 }
      rest = cards - three if three
      return yield nil, cards unless three && rest.first.versus(rest.last) == 0
      yield self.new(rest + three), []
    end

    def nominal_value
      6
    end
  end
end
