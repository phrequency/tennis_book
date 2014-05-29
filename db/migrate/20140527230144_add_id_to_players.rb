class AddIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :user_usta_id, :string
  end
end
