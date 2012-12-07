require 'spec_helper'

RSpec::Matchers.define :win_against do |challenger|
  match { |hand| (hand <=> challenger) == 1 }
end

RSpec::Matchers.define :tie_against do |challenger|
  match { |hand| (hand <=> challenger) == 0 }
end

RSpec::Matchers.define :lose_against do |challenger|
  match { |hand| (hand <=> challenger) == -1 }
end

describe Poker::Hand do
  [
    'garbage',
    '2H 2D 2S 2C',
    '7C 8C 9C 10H JS QH',
    '11D 3C QS KC AH',
    '8H 9G 3C 7D KH'
  ].each do |garbage|
    context "given #{garbage}" do
      it { expect { Poker::Hand.new(garbage) }.to raise_error ArgumentError }
    end
  end

  {
    '10D 2S 2C KH QD'    => '2C 2S 10D QD KH',
    '10D 10C 10S 10H 2S' => '2S 10C 10D 10H 10S',
    'AD QD AC QC JH'     => 'JH QC QD AC AD'
  }.each do |given, expected|
    context "given these cards: #{given}" do
      subject { Poker::Hand.new(given) }

      its(:to_s) { should == expected }
    end
  end

  describe '<=>' do
    def self.pit hand, options = {}
      challenger_hand = options[:against]
      expected = :"#{options[:to]}_against"
      context "#{hand}" do
        let(:challenger) { Poker::Hand.new(challenger_hand) }
        subject { Poker::Hand.new(hand) }

        it { should send(expected, challenger) }
      end
    end

    context "nothing VS" do
      context "nothing" do
        pit '8C 2H 7D 3D 9C',  against: '4H 7S 2D 3S 5D',  to: :win
        pit '7S 8S 9S 10S 5D', against: '8D 9D 10D 5H 2D', to: :win
        pit '8C 2H 7D 10D 9C', against: '7H QS 8D 2S 9D',  to: :lose
        pit '3D 4S 2S JS KH',  against: '3H 2H 5D KD JH',  to: :lose
        pit 'JH AD KS QH 2D',  against: '2H AS QD KC JS',  to: :tie
        pit '10H AD KD 9C 7D', against: '10C 7C 9H KC AC', to: :tie
      end
    end

    context "pair VS" do
      context "nothing" do
        pit '2C 2S 3C 4C 5C',  against: '10C JC KC QC 5S', to: :win
        pit '8C 7H 10C 9C 5D', against: '4D 5H 5C 6H 7S',  to: :lose
      end

      context "pair" do
        pit '2C 8H 4D 7H 8S',  against: 'KS QS 7D 7C JS', to: :win
        pit '4S 4C KS 8H JC',  against: 'JH KC 4H 8C 4D', to: :tie
        pit 'KH 9S QD 9H 10S', against: 'KC QC 9C JC 9D', to: :lose
      end
    end

    context "two pairs VS" do
      context "nothing" do
        pit '2C 2H QD 3S 3H',  against: 'KD JD QH AD 7H', to: :win
        pit 'KH 7C 8C 9C 10C', against: '4H 5C 5S 6C 6H', to: :lose
      end

      context "pair" do
        pit 'QD 7D QH 8C 7H',   against: 'AD AH KD QC JS', to: :win
        pit '7D 10D 10H 6S 5C', against: '3H 4H 5H 5S 4D', to: :lose
      end

      context "two pair" do
        pit 'QD QS 7H 5S 7S',   against: '10S KC 10S 7C 7D', to: :win
        pit 'JS 8C JC 8H 3C',   against: 'AD JH JD 7S 7D',   to: :win
        pit '2S 3S 2C 3H 4D',   against: '3D 3C 4H 2D 2H',   to: :tie
        pit '9H 9D 4S 10C 10D', against: '10S 10H 9C 9S 5C', to: :lose
      end
    end

    context "three of a kind VS" do
      context "nothing" do
        pit '7D 3S 4C 7H 7C',  against: 'AS KS JS QS 8C', to: :win
        pit '2D 3H 4C 5S 10H', against: 'JH JC JS 2S 3C', to: :lose
      end

      context "pair" do
        pit '3C 8D 8C 8H 5S',   against: '5C JH JD 10S 9C', to: :win
        pit '10S 9D 10H JC 7D', against: '4C 4D 9S 4S KS', to: :lose
      end

      context "two pair" do
        pit 'JC JS JH 2S 5D', against: 'KS QD KC QH AS', to: :win
        pit '8S 9S 8H 9C KH', against: '7S 5C 7H 5D 7C', to: :lose
      end

      context "three of a kind" do
        pit '5C 5D 5S 7H 8C', against: '4C 4D 4S 7D 8H',  to: :win
        pit 'JC KH KC QS KD', against: '10C AS 8D AC AD', to: :lose
      end
    end

    context "flush VS" do
      context "nothing" do
        pit '4C JC 10C 8C 3C', against: '4S JH 10S 8S 3S', to: :win
        pit 'AS QS KS JS 9C',  against: '2S 4S 5S 6S 8S',  to: :lose
      end

      context "pair" do
        pit '2H 8H 7H JH 4H', against: 'AS AH 9H 10S 2S', to: :win
        pit '2S 3C 4S 7H 8S', against: 'JC KC QC 9C 3C', to: :lose
      end

      context "two pair" do
        pit '8C 4C 7C KC 10C',  against: 'JC JS 10D AD AH', to: :win
        pit 'KC KD 10C 10S 9H', against: '9D 7D JD AD 5D',  to: :lose
      end

      context "three of a kind" do
        pit '2S 4S 6S 8S 9S', against: '10H 10S AH 10C 9H', to: :win
        pit 'AS 5S 5H 5C 6S', against: 'JC 5C 6C KC 7C',    to: :lose
      end

      context "flush" do
        pit '4C JC 6C 8C 7C',   against: '10S 9S 6S 4S 7S', to: :win
        pit '7D 8D 10D 9D 5D',  against: '5S 7S 8S 10S 9S', to: :tie
        pit '3H 2H 10H 6H JH',  against: 'AC 2C 3C 5C 4C',  to: :lose
      end
    end
  end
end
