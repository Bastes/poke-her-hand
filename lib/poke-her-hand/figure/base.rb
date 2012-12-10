class PokeHerHand::Figure::Base
  include Enumerable
  include Comparable

  def self.match cards
    yield self.new(cards)
  end

  def initialize cards
    @cards = cards
  end

  def each *args, &block
    @cards.each *args, &block
  end

  def to_s
    @cards.map(&:to_s).join ' '
  end

  def <=> challenger
    (nominal_value <=> challenger.nominal_value).tap { |c| return c unless c == 0 }
    -challenger.challenge(@cards)
  end

  def nominal_value
    0
  end

  protected

  def challenge cards
    @cards.zip(cards).reverse.inject(0) { |r, (a, b)| (a.versus(b)).tap { |r| return r unless r== 0 } }
  end
end
