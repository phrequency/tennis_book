class TournamentsController < ApplicationController

	before_filter :authenticate_user!

  def my_tournaments
    @user = current_user
    @player = current_user.active_player
    @my_tournaments = @player.tournaments
    @tournament = Tournament.new
  end

  def create
  	@user = current_user
    @player = current_user.active_player
    @tournament = @player.tournaments.build(params[:tournament])
    if @tournament.save
    	flash[:notice] = "Tournament saved!"
    	redirect_to tournament_path(@tournament)
    else
    	flash[:error] = "Please fill out all the required fields"
    	redirect_to my_tournaments_path
    end
  end

  def edit
  	@tournament = Tournament.find(params[:id])
  	@user = current_user
    @player = current_user.active_player
    @tmatch = Tmatch.new
  	unless @tournament.player == @player
  		redirect_to dash_path
  	end
  end


end
