class AddDoublesToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :doubles, :string
  end
end
