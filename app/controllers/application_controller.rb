class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
  	if current_user.accounts.where(active: "true").first
      if current_user.active_player.birthday && current_user.active_player.gender
  		  dash_path
      else
        flash[:notice] = "Please finish your registration process"
        step2_path
      end
  	else
  		loading_path
  	end
  	
  end

end
