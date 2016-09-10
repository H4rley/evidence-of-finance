class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.boolean :send_notifications
      t.integer :critical_amount

      t.timestamps null: false
    end
  end
end
