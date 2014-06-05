class RemoveColFromTournaments < ActiveRecord::Migration
  def up
  	remove_column :tournaments, :player
  	remove_column :tournaments, :opponent
  end

  def down
  end
end
