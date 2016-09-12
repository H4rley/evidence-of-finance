require "rails_helper"

RSpec.describe Transactions::Provider, type: :model do

  describe "initialize" do
    it "assigns" do
      trans = create :transaction
      account = create :account
      provider = described_class.new({transaction: trans, account: account})
      expect(provider.transaction).to eq(trans)
      expect(provider.account).to eq(account)
    end
  end

  describe "update_account" do
    it "not updates account because transaction has invalid sum", :focus do
      account = create :account, sum: 500
      trans = build :transaction, sum: "invalid_sum", movement: 'input', account: account
      provider = described_class.new({transaction: trans, account: account})

      expect{provider.update_account}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "successfully" do
      account = create :account, sum: 500
      trans = build :transaction, sum: 100, movement: 'input', account: account
      provider = described_class.new({transaction: trans, account: account})
      expect(provider.update_account).to be
      expect(account.sum).to eq 600
    end
  end

  describe "notify user" do
    it "does not notify user if he has turned off notifications" do
      account = create :account, sum: 500, send_notifications: false
      trans = create :transaction, sum: 1000, movement: 'output', account: account
      provider = described_class.new({transaction: trans, account: account})
      expect(provider.notify_user).to_not be
    end

    it "notifies user if he has turned on notifications" do
      account = create :account, sum: 500, send_notifications: true, critical_amount: 1000
      trans = create :transaction
      provider = described_class.new({transaction: trans, account: account})
      expect{provider.notify_user}.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

end