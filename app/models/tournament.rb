class Tournament < ActiveRecord::Base
  attr_accessible :comments, :date, :location, :name, :player_1, :player_2, :result, :score

  belongs_to :player

  validates :name, presence: true
  validates :location, presence: true
  validates :player_1, presence: true
  validates :player_2, presence: true
  validates :result, presence: true
  validates :score, presence: true
  validates :date, presence: true


end
