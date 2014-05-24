class RemovePrimaryFromPlayers < ActiveRecord::Migration
  def up
  	remove_column :players, :primary
  end

  def down
  end
end
