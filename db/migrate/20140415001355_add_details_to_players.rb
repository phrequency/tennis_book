class AddDetailsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :location, :string
    add_column :players, :overall_record, :string
    add_column :players, :date_range, :string
  end
end
