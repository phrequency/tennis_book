a = [{:name => "Lexi Bari", :usta_id => "2010115347"}, {:name => "Isabella Pescatore"}, {:name => "Tiffany Yeung"}, {:name => "Sabrina Yeung", :usta_id => "2010264178"}, {:name => "Kendall Skalicky"}, {:name => "Chloe Abramowitz"}, {:name => "Talia Levine"}, {:name => "Esha Velaga", :usta_id => "2010322555"}, {:name => "Ruthie Njagi"}, {:name => "Amelia Honer"}, {:name => "Sasha Getz"}, {:name => "Sophie Cohen"}, {:name => "Ethan Carr"}, {:name => 'Oscar Gerber', :usta_id => "2010167949"}, {:name => "Julian Casabon", :usta_id => "2010088590"}, {:name => "Andrew Comiskey"}, {:name => "Joshua Lai"}, {:name => "Sloan Steinberg"}, {:name => "Ethan Blum"}, {:name => "Keith Bunn"}, {:name => "Newman Yeilding"}, {:name => "Aidan Yeilding"}, {:name => "Jamie Slater"}, {:name => "Justin Minerva"}]
#a = [{:name => "Ethan Carr"}, {:name => 'Oscar Gerber', :usta_id => "2010167949"}, {:name => "Julian Casabon", :usta_id => "2010088590"}, {:name => "Andrew Comiskey"}, {:name => "Joshua Lai"}, {:name => "Sloan Steinberg"}, {:name => "Ethan Blum"}, {:name => "Keith Bunn"}, {:name => "Newman Yeilding"}, {:name => "Aidan Yeilding"}, {:name => "Jamie Slater"}, {:name => "Justin Minerva"}]

a.each do |user|
	first_name = user[:name].split(' ').first
	last_name = user[:name].split(' ').last
	if user[:usta_id]
		usta_id = user[:usta_id]
	else
		usta_id = "0123456789"
	end
	User.create(first_name: first_name, last_name: last_name, email: first_name + "@" + last_name + ".com", password: "11223344", usta_id: usta_id)
end

# 	# User.find(:all, :conditions => ["id != ?", 256]).each do |f|
# 	# 	Friendship.create(user_id: 256, friend_id: f.id)
# 	# 	Friendship.create(user_id: f.id, friend_id: 256)
# 	# end

# 	# Delayed::Job.delete_all && User.delete_all && Player.delete_all && Friendship.delete_all && Match.delete_all



