class AddMoreToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :section, :string
    add_column :players, :club, :string
    add_column :players, :favorites, :string
    add_column :players, :mentor, :string
    add_column :players, :coach, :string
    add_column :players, :colleges, :text
  end
end
