class Match < ActiveRecord::Base
  attr_accessible :name, :player1_id, :player2_id, :result, :score

  belongs_to :player, foreign_key: 'player1_id', class_name: 'Player'
  belongs_to :opponent, foreign_key: 'player2_id', class_name: 'Player'
  
end
