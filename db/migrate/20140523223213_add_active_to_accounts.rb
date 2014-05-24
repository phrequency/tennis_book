class AddActiveToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :active, :string
  end
end
