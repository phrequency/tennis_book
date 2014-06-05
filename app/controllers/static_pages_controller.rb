class StaticPagesController < ApplicationController

	before_filter :authenticate_user!, only: [:loading]

	def home
		if current_user
			@user = current_user
		end
	end

	def loading
		@user = current_user
		if @user.accounts.where(active: "true").first
      		if @user.active_player
      			flash[:notice] = "Please finish your registration process"
        		redirect_to step2_path
      		end
      	end
	end

	def privacy
	end

end
