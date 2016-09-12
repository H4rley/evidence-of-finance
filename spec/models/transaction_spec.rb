require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe "total_sum" do
    before(:each) do
      @one_day_ago = Time.now - 1.day
      create :transaction, sum: 400, created_at: Time.now
      create :transaction, sum: 100, created_at: @one_day_ago
      create :transaction, sum: 200, created_at: @one_day_ago - 1.day
    end

    it "return total sum of transactions within 1 day" do
      expect(Transaction.total_sum(@one_day_ago, Time.now)).to eq(500)
    end

    it "returns 0 as total sum" do
      expect(Transaction.total_sum(Time.now, Time.now)).to eq(0)
    end
  end

  describe "for_incomes" do
    it "returns transactions with incomes" do
      trans = create :transaction, movement: "input"
      expect(Transaction.for_inputs).to include(trans)
    end

    it "returns no transactions" do
      trans = create :transaction, movement: "output"
      expect(Transaction.for_inputs).to_not include(trans)
    end
  end

  describe "for_outputs" do
    it "returns transactions with outcomes" do
      trans = create :transaction, movement: "output"
      expect(Transaction.for_outputs).to include(trans)
    end

    it "returns no transactions" do
      trans = create :transaction, movement: "input"
      expect(Transaction.for_outputs).to_not include(trans)
    end
  end

end
