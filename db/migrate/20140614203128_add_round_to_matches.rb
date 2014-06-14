class AddRoundToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :round, :string
  end
end
