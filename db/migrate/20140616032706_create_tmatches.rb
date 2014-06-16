class CreateTmatches < ActiveRecord::Migration
  def change
    create_table :tmatches do |t|
      t.integer :tournament_id
      t.string :score
      t.string :result
      t.string :player
      t.string :player_1
      t.string :player_2
      t.string :round

      t.timestamps
    end
    add_index :tmatches, :tournament_id
  end
end
