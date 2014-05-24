class AddPlayeridToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :player_id, :integer
  end
end
