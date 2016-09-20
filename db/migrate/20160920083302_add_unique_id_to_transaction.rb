class AddUniqueIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :unique_id, :string
  end
end
