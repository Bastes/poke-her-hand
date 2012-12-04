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
end
