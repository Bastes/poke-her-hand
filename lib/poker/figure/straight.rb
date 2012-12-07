module Poker::Figure
  class Straight < Base
    def self.match cards, &block
      flush = cards[0,4].zip(cards[1,4]).all? { |(a,b)| a.pred_value_to? b }
      return yield nil, cards unless flush
      yield self.new(cards), []
    end

    def nominal_value
      4
    end
  end
end
