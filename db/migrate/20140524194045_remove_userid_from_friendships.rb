class RemoveUseridFromFriendships < ActiveRecord::Migration
  def up
  	remove_column :friendships, :user_id
  end

  def down
  end
end
