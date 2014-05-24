class Account < ActiveRecord::Base
  attr_accessible :player_id, :user_id, :active

  belongs_to :user
  belongs_to :player
end
