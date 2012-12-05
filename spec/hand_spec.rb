require 'spec_helper'

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
    '10D 2S 2C KH QD' => '2C 2S 10D QD KH',
    '10D 10C 10S 10H 2S' => '2S 10C 10D 10H 10S',
    'AD QD AC QC JH' => 'JH QC QD AC AD'
  }.each do |given, expected|
    context "given these cards: #{given}" do
      subject { Poker::Hand.new(given) }

      its(:to_s) { should == expected }
    end
  end

  describe '<=>' do
    context "spare VS spare" do
      {
        ['8C 2H 7D 10D 9C', '7H QS 8D 2S 9D']  => -1,
        ['8C 2H 7D 3D 9C',  '4H 7S 2D 3S 5D']  => 1,
        ['3D 4S 2S JS KH',  '3H 2H 5D KD JH']  => -1,
        ['JH AD KS QH 2D',  '2H AS QD KC JS']  => 0,
        ['10H AD KD 9C 7D', '10C 7C 9H KC AC'] => 0,
        ['7S 8S 9S 10S 5D', '8D 9D 10D 5H 2D'] => 1
      }.each do |(hand, challenger), expected_result|
        context "#{hand} VS #{challenger}" do
          subject { Poker::Hand.new(hand) <=> Poker::Hand.new(challenger) }

          it { should == expected_result }
        end
      end
    end
  end
end
