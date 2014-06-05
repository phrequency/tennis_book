class AddColToTournaments < ActiveRecord::Migration
  def change
  	add_column :tournaments, :player_1, :string
  	add_column :tournaments, :player_2, :string
  end
end
