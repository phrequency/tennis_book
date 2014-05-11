class AddParentemailToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :parent_email, :string
  end
end
