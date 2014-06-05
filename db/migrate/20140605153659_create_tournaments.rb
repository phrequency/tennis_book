class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :player
      t.string :opponent
      t.string :name
      t.string :location
      t.string :result
      t.datetime :date
      t.text :comments
      t.string :score

      t.timestamps
    end
  end
end
