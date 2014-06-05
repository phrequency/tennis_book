class RegistrationController < Devise::RegistrationsController


	def create
		name = params[:user][:first_name].downcase + " " + params[:user][:last_name].downcase
		beta_testers = ["Lexi Bari", "Isabella Pescatore", "Tiffany Yeung", "Sabrina Yeung", "Kendall Skalicky", "Chloe Abramowitz", "Talia Levine", "Esha Velaga", "Ruthie Njagi", "Amelia Honer", "Sasha Getz", "Sophie Cohen", "Ethan Carr", 'Oscar Gerber', "Julian Casabon", "Andrew Comiskey", "Joshua Lai", "Sloan Steinberg", "Ethan Blum", "Keith Bunn", "Newman Yeilding", "Aidan Yeilding", "Jamie Slater", "Justin Minerva"].map(&:downcase)
		if beta_testers.include? name
			super
		else
			flash[:notice] = "Sorry, we are currently in private beta. Contact ____ to get access!"
			redirect_to :back
		end
	end

end