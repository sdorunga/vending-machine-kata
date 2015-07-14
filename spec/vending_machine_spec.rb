require 'spec_helper'
require_relative '../lib/vending_machine.rb'

RSpec.describe VendingMachine do
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

  describe "#select_product" do
    it 'returns the selected product if the user has paid enough' do
      subject.insert_coins([quarter])
      subject.insert_coins([quarter])
      expect(subject.select_product("chips")).to eq("chips")
    end
  end

  describe "#check_display" do
    it "displays INSERT COINS when checked if there are no coins inserted yet" do
      expect(subject.check_display).to eq("INSERT COINS")
    end

    it "displays running total when a coin is already inserted" do
      subject.insert_coins([nickel])
      expect(subject.check_display).to eq("0.05")
    end

    it "displays running total when two coins are already inserted" do
      subject.insert_coins([nickel])
      subject.insert_coins([quarter])
      expect(subject.check_display).to eq("0.30")
    end

    it "does not update the current balance on invalid coins" do
      subject.insert_coins([penny])
      expect(subject.check_display).to eq("INSERT COINS")
    end

    it "updates the current balance on a mix of valid and invalid coins" do
      subject.insert_coins([penny, nickel, dime, quarter])
      expect(subject.check_display).to eq("0.40")
    end

    describe 'when selecting products' do
      context "when price of items is equal to the current balance" do
        it 'shows a thank you message after being given the product' do
          subject.insert_coins([quarter])
          subject.insert_coins([quarter])
          subject.select_product("chips")
          expect(subject.check_display).to eq("THANK YOU")
        end

        it 'checking the display a second time it displays INSERT COINS' do
          subject.insert_coins([quarter])
          subject.insert_coins([quarter])
          subject.select_product("chips")
          subject.check_display
          expect(subject.check_display).to eq("INSERT COINS")
        end
      end

      context "when price of items is lower than the current balance" do
        it 'shows a thank you message after being given the product' do
          subject.insert_coins([quarter])
          subject.insert_coins([quarter])
          subject.select_product("chips")
          expect(subject.check_display).to eq("THANK YOU")
        end

        it 'checking the display a second time it displays the current balance' do
          subject.insert_coins([quarter])
          subject.insert_coins([quarter])
          subject.insert_coins([quarter])
          subject.select_product("chips")
          subject.check_display
          expect(subject.check_display).to eq("0.25")
        end
      end

      context "when price of items is higher than the current balance" do
        it 'shows a thank you message after being given the product' do
          subject.insert_coins([quarter])
          subject.select_product("chips")
          expect(subject.check_display).to eq("PRICE 0.50")
        end

        it 'checking the display a second time it displays the current balance' do
          subject.insert_coins([quarter])
          subject.select_product("chips")
          subject.check_display
          expect(subject.check_display).to eq("0.25")
        end
      end
    end
  end
end
