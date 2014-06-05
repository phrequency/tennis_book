class AddOwnerToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :player_id, :integer
    add_index :tournaments, :player_id
  end
end
