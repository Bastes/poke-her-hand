module Poker
  class Hand
    include Comparable

    ACCEPTABLE = /\A(([2-9JQKA]|10)[CDHS])( ([2-9JQKA]|10)[CDHS]){4}\Z/

    def initialize(cards)
      acceptable! cards
      cards = cards.split(/ /).map { |c| Card.new c }.sort!
      @figures = []
      Figure::Pair.match(cards) do |pair, rest|
        @figures << pair if pair
        @figures << Figure::Nothing.new(rest)
      end
    end

    def to_s
      @figures.map(&:to_a).flatten.sort.map(&:to_s).join ' '
    end

    def <=> challenger
      -challenger.challenge(@figures)
    end

    protected

    def challenge figures
      @figures.zip(figures).inject(0) { |r, (a, b)| (a <=> b).tap { |r| return r unless r == 0 } }
    end

    def acceptable! cards
      return true if cards =~ ACCEPTABLE
      raise ArgumentError.new("#{cards} is not a poker hand")
    end
  end
end
