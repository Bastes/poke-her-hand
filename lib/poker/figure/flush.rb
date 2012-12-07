module Poker::Figure
  class Flush < Base
    def self.match cards, &block
      card = cards.first
      return yield nil, cards unless cards.all? { |c| c.same_color_as? card }
      yield self.new(cards), []
    end

    def nominal_value
      4
    end
  end
end
