class AddMovementToTransactionsTable < ActiveRecord::Migration
  def change
    add_column :transactions, :movement, :string
  end
end
