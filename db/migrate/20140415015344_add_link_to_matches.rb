class AddLinkToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :link, :text
  end
end
