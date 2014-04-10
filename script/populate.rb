a = ["Lexi Bari", "Isabella Pescatore", "Tiffany Yeung", "Sabrina Yeung", "Kendall Skalicky", "Chloe Abramowitz", "Talia Levine", "Esha Velaga", "Ruthie Njagi", "Amelia Honer", "Sasha Getz", "Sophie Cohen"]

a.each do |user|
	first_name = user.split(' ').first
	last_name = user.split(' ').last
	User.create(first_name: first_name, last_name: last_name, email: first_name + "@" + last_name + ".com", password: "11223344" )
end