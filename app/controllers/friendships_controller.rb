class FriendshipsController < ApplicationController

	def create
		@friendship = Friendship.create(:friend_id => params[:friend_id], :user_id => current_user.id)
		redirect_to :back
	end
end
