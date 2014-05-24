class StaticPagesController < ApplicationController

	before_filter :authenticate_user!, only: [:loading]

	def home
	end

	def loading
		if current_user.accounts.where(active: "true").first
      		if current_user.active_player
      			flash[:error] = "Please add additional account info below!"
        		redirect_to profile_path
      		end
      	end
	end

end
