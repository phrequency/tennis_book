class PlayersController < ApplicationController
  
  before_filter :authenticate_user!

	def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to dash_path, notice: 'Update successful!' }
      else
        format.html { redirect_to :back, notice: 'Please try again' }
      end
    end
  end

  def send_friend_invite
    if params[:email]
      UserMailer.delay.send_invite(current_user.active_player, params[:email])
      flash[:notice] = "Invite successfully sent!"
      redirect_to dash_path
    else
      flash[:notice] = "Please enter a valid email address"
      redirect_to dash_path
    end
  end

  def opponent_profile
    @opponent = Player.find(params[:id])
    @user = current_user
    @player = @user.active_player
  end


end
