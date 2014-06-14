class Match < ActiveRecord::Base
  attr_accessible :name, :player1_id, :player2_id, :result, :score, :link, :date, :doubles, :partner, :round

  belongs_to :player, foreign_key: 'player1_id', class_name: 'Player'
  belongs_to :opponent, foreign_key: 'player2_id', class_name: 'Player'
  

  def real_datetime
  	Date.parse(self.date.split('/')[2] + '-' + self.date.split('/')[0] + '-' + self.date.split('/')[1]).to_datetime
  end


end
