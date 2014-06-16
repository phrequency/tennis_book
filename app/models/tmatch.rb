class Tmatch < ActiveRecord::Base
  attr_accessible :player, :player_1, :player_2, :result, :round, :score, :tournament_id

  belongs_to :tournament
end
