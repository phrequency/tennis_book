class PlayersController < ApplicationController

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

end
