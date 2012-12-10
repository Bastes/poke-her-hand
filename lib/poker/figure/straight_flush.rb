module Poker::Figure
  class StraightFlush < Base
    def self.match cards, &block
      straight_flush = cards[0,4].zip(cards[1,4]).all? do |(a,b)|
        a.pred_value_to?(b) && a.same_color_as?(b)
      end
      yield self.new(cards) if straight_flush
    end

    def nominal_value
      8
    end
  end
end
