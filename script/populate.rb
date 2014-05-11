a = ["Lexi Bari", "Isabella Pescatore", "Tiffany Yeung", "Sabrina Yeung", "Kendall Skalicky", "Chloe Abramowitz", "Talia Levine", "Esha Velaga", "Ruthie Njagi", "Amelia Honer", "Sasha Getz", "Sophie Cohen"]

a.each do |user|
	first_name = user.split(' ').first
	last_name = user.split(' ').last
	User.create(first_name: first_name, last_name: last_name, email: first_name + "@" + last_name + ".com", password: "11223344", usta_id: "testid" )
end

# 	# User.find(:all, :conditions => ["id != ?", 256]).each do |f|
# 	# 	Friendship.create(user_id: 256, friend_id: f.id)
# 	# 	Friendship.create(user_id: f.id, friend_id: 256)
# 	# end

# 	# Delayed::Job.delete_all && User.delete_all && Player.delete_all && Friendship.delete_all && Match.delete_all

