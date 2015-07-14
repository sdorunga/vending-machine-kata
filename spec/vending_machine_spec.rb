require 'spec_helper'
require_relative '../lib/vending_machine.rb'

RSpec.describe VendingMachine do
  describe "#insert_coins"do
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

    it "updates the current balance from a valid coin" do
      expect(subject.insert_coins([nickel])).to eq("0.05")
    end

    it "does not update the current balance on invalid coins" do
      expect(subject.insert_coins([penny])).to eq("0.00")
    end

    it "updates the current balance on a mix of valid and invalid coins" do
      expect(subject.insert_coins([penny, nickel, dime, quarter])).to eq("0.40")
    end
  end
end
