require 'spec_helper'
require_relative '../lib/coin_machine.rb'

RSpec.describe CoinMachine do
  let(:penny) do
    {weight: 2.5, size: 19}
  end
  let(:nickel) do
    {weight: 5, size: 21}
  end
  let(:dime) do
    {weight: 2.2, size: 18}
  end
  let(:quarter) do
    {weight: 5.6, size: 24}
  end

  describe "#add_coin" do
    it "Accepts valid coins and returns their value" do
      subject.add_coin(dime)
      expect(subject.inserted_coins_value).to eq(10)
    end

    it "Rejects invalid coins" do
      subject.add_coin(penny)
      expect(subject.inserted_coins_value).to eq(0)
    end
  end

  describe "#pay" do
    it "Returns correct change when price is lower than the inserted amount" do
      subject.add_coin(nickel)
      subject.add_coin(dime)
      subject.add_coin(quarter)
      expect(subject.pay(25).map {|coin| coin[:name]}).to eq(['dime', 'nickel'])
    end

    it "Returns correct change when paying nothing" do
      subject.add_coin(nickel)
      subject.add_coin(dime)
      subject.add_coin(quarter)
      expect(subject.pay(0).map {|coin| coin[:name]}).to eq(['quarter', 'dime', 'nickel'])
    end
  end
end
