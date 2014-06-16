class TmatchesController < ApplicationController

	def create
		@user = current_user
	    @player = current_user.active_player
	    @tournament = Tournament.find(params[:tmatch][:tournament_id])
	    @tmatch = @tournament.tmatches.build(params[:tmatch])
	    if @tmatch.save
    		flash[:notice] = "Match saved!"
    		redirect_to tournament_path(@tournament)
	    else
	    	flash[:error] = "Please fill out all the required fields"
	    	redirect_to tournament_path(@tournament)
	    end
	end

end
