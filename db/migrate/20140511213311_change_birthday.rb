class ChangeBirthday < ActiveRecord::Migration
  def up
  	remove_column :players, :birthday
  	add_column :players, :birthday, :datetime
  end

  def down
  end
end
