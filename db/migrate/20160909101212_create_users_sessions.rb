class CreateUsersSessions < ActiveRecord::Migration
  def change
    create_table :users_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :action
      t.string :authentication

      t.timestamps null: false
    end
  end
end
