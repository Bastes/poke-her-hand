module PokeHerHand::Figure
  class Flush < Base
    def self.match cards, &block
      card = cards.first
      yield self.new(cards) if (cards - [card]).all? { |c| c.same_color_as? card }
    end

    def nominal_value
      5
    end
  end
end
