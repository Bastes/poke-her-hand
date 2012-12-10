module PokeHerHand::Figure
  class Straight < Base
    def self.match cards, &block
      flush = cards[0,4].zip(cards[1,4]).all? { |(a,b)| a.pred_value_to? b }
      yield self.new(cards) if flush
    end

    def nominal_value
      4
    end
  end
end
