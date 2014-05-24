class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :player_id

      t.timestamps
    end
    add_index :accounts, :user_id
    add_index :accounts, :player_id
  end
end
