class AddDistrictToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :district, :string
  end
end
