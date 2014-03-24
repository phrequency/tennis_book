class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.string :result
      t.string :score
      t.string :name

      t.timestamps
    end
    add_index :matches, :player1_id
    add_index :matches, :player2_id
  end
end
