class AddUstaidToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :usta_id, :string
  end
end
