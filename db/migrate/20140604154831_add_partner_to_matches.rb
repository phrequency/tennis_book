class AddPartnerToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :partner, :string
  end
end
