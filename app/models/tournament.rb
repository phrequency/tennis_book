class Tournament < ActiveRecord::Base
  attr_accessible :comments, :date, :location, :name, :player_1, :player_2, :result, :score

  belongs_to :player

  validates :name, presence: true
  validates :location, presence: true 
  validates :date, presence: true

  has_many :tmatches


end
