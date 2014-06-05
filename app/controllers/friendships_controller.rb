class FriendshipsController < ApplicationController

	before_filter :authenticate_user!
	
	def create
		@friendship = Friendship.create(:friend_id => params[:friend_id], :player_id => current_user.active_player.id)
		redirect_to :back
	end
end
