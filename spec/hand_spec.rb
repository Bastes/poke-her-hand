require 'spec_helper'

describe Poker::Hand do
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
