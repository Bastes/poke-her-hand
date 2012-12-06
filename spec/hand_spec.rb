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

    context "nothing VS nothing" do
      pit '8C 2H 7D 3D 9C',  against: '4H 7S 2D 3S 5D',  to: :win
      pit '7S 8S 9S 10S 5D', against: '8D 9D 10D 5H 2D', to: :win
      pit '8C 2H 7D 10D 9C', against: '7H QS 8D 2S 9D',  to: :lose
      pit '3D 4S 2S JS KH',  against: '3H 2H 5D KD JH',  to: :lose
      pit 'JH AD KS QH 2D',  against: '2H AS QD KC JS',  to: :tie
      pit '10H AD KD 9C 7D', against: '10C 7C 9H KC AC', to: :tie
    end

    context "pair VS nothing" do
      pit '2C 2S 3C 4C 5C',  against: '10C JC KC QC 5S', to: :win
      pit '8C 7H 10C 9C 5D', against: '4D 5H 5C 6H 7S',  to: :lose
    end

    context "pair VS pair" do
      pit '2C 8H 4D 7H 8S',  against: 'KS QS 7D 7C JS', to: :win
      pit '4S 4C KS 8H JC',  against: 'JH KC 4H 8C 4D', to: :tie
      pit 'KH 9S QD 9H 10S', against: 'KC QC 9C JC 9D', to: :lose
    end
  end
end
