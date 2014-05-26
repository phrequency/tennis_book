class AddMoredetailsToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :racket, :string
  	add_column :players, :strings, :string
  	add_column :players, :shoes, :string
  	add_column :players, :clothing, :string
  	add_column :players, :hand, :string
  	add_column :players, :hometown, :string
  	add_column :players, :school, :string
  	add_column :players, :grade, :string
  end
end
