class AddPrimaryToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :primary, :string
  end
end
