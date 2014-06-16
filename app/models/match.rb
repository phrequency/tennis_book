class Match < ActiveRecord::Base
  attr_accessible :name, :player1_id, :player2_id, :result, :score, :link, :date, :doubles, :partner, :round

  belongs_to :player, foreign_key: 'player1_id', class_name: 'Player'
  belongs_to :opponent, foreign_key: 'player2_id', class_name: 'Player'
  

  def real_datetime
  	Date.parse(self.date.split('/')[2] + '-' + self.date.split('/')[0] + '-' + self.date.split('/')[1]).to_datetime
  end

  def real_round_name(round)
    if round == 'F'
      "Finals"
    elsif round == 'PL'
      "Playoff"
    elsif round == "SF"
      "Semifinals"
    elsif round == "QF"
      "Quarterfinals"
    elsif round == "16"
      "16"
    elsif round == "32"
      "32"      
    elsif round == "64"
      "64"
    elsif round == "128"
      "128"
    elsif round == "256"
      "256"
    elsif round == "RR"
      "Round Robin"    
    elsif round == "QQ"
      "Quarterfinal Qualifier"
    elsif round == "R5"
      "Round 5"
    elsif round == "R4"
      "Round 4"      
    elsif round == "R3"
      "Round 3"
    elsif round == "R2"
      "Round 2"
    elsif round == "R1"
      "Round 1"
    elsif round == "5Q"
      "Round 5 Qualifier"
    elsif round == "4Q"
      "Round 4 Qualifier"
    elsif round == "3Q"
      "Round 3 Qualifier"
    end
  end


end
