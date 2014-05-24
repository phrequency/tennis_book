class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :player_id

  belongs_to :player
  belongs_to :friend, :class_name => 'Player'
end
