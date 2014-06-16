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

  def get_districts
    section = params[:section]
    if section == "Caribbean"
      a = [
        ["Puerto Rico"],
        ["Virgin Islands"]
      ]
    elsif section == "Eastern"
      a = [
        ["Western Region"],
        ["Metropolitan Region" ],
        ["Long Island Region"],
        ["Northern Region"],
        ["Southern Region"],
        ["New Jersey Region"]
      ]
    elsif section == "Florida"
      a = [
        ["Region 1"],
        ["Region 2"],
        ["Region 3"],
        ["Region 4"],
        ["Region 5"],
        ["Region 6"],
        ["Region 7"],
        ["Region 8"]
      ]
    elsif section == "Foreign"
      a = [
       ["Foreign"],
      ]
    elsif section == "Hawaii Pacific"
      a = [
        ["East Hawaii"],
        ["Kauai"],
        ["Maui"],
        ["Oahu"],
        ["American Samoa-Guam"],
        ["West Hawaii"]
      ]
    elsif section == "Intermountain"
     a =  [
        ["Southern Nevada"],
        ["Colorado"],
        ["Idaho"],
        ["Montana"],
        ["Utah"],
        ["Wyoming"]
      ]
    elsif section == "Mid-Atlantic"
      a = [
        ["Delaware"],
        ["Central Pennsylvania"],
        ["Eastern Pennsylvania"],
        ["Philadelphia"],
        ["Allegheny Mountain"],
        ["New Jersey"]
      ]
    elsif section == "Middle States"
     a =  [
        ["Delaware"],
        ["Central Pennsylvania"],
        ["Eastern Pennsylvania"],
        ["Philadelphia"],
        ["Allegheny Mountain"],
        ["New Jersey"]
      ]
    elsif section == "Midwest"
     a =  [
        ["Central Indiana"],
        ["Chicago"],
        ["N.E. Michigan"],
        ["S.E. Michigan "],
        ["Western Michigan"],
        ["Northern Indiana"],
        ["Ohio Valley"],
        ["Northeastern Ohio"],
        ["Northwestern Ohio"],
        ["Wisconsin"],
        ["Northern Michigan"],
        ["Mid-South Illinois"]
      ]
    elsif section == "Missouri Valley"
     a = [
        ["Heart of America"],
        ["Iowa"],
        ["Kansas"],
        ["Nebraska"],
        ["Oklahoma"],
        ["St. Louis"],
        ["Missouri"]
      ]
    elsif section == "New England"
    a = [
      ["New Hampshire"],
      ["Vermont"],
      ["Eastern Massachusetts"],
      ["Western Massachusetts"],
      ["Rhode Island"],
      ["Connecticut"],
      ["Maine"]
    ]
    elsif section == "Northern California"
      a = [
        ["Northern California"]
      ]
    elsif section == "Northern"
      a = [
        ["Northern"]
      ]
    elsif section == "Pacific Northwest"
      a = [
        ["Southern Oregon"],
        ["Eastern Washington"],
        ["Alaska"],
        ["Idaho"],
        ["Northern Oregon"],
        ["British Columbia"],
        ["Southwest Washington"],
        ["Northwest Washington"],
      ]
    elsif  section == "Southern California"
      a = [
        ["Southern California"],
        ["San Diego"]
      ]
    elsif section == "Southern"
     a =  [
        ["Alabama"],
        ["Arkansas"],
        ["Georgia"],
        ["Kentucky"],
        ["Louisiana"],
        ["Mississippi"],
        ["North Carolina"],
        ["South Carolina"],
        ["Tennessee"]
      ]
    elsif section == "Southwest"
      a = [
        ["Northern Arizona"],
        ["Northern New Mexico"],
        ["Southern Arizona"],
        ["Central Arizona"],
        ["Greater El Paso"],
        ["Southern New Mexico"],
        ["Southeast New Mexico"]
      ] 
    elsif section == "Texas"
        a = [
          ["Texas"]
        ]
    end
    render json: a
  end


end
