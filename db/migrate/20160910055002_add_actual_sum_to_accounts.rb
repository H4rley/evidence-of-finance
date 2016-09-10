class AddActualSumToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :sum, :decimal
  end
end
