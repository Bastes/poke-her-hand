module Poker::Figure
  class FourOfAKind < Base
    def self.match cards, &block
      four = [cards[0,4], cards[1,4]].
        detect { |set| a = set.first; set[1,3].all? { |b| b.versus(a) == 0 } }
      yield self.new(four), Nothing.new(cards - four) if four
    end

    def nominal_value
      7
    end
  end
end
