class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :usta_id
      t.integer :user_id

      t.timestamps
    end
    add_index :players, :user_id
  end
end
