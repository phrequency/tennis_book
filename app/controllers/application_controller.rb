class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
  	if current_user.player.birthday && current_user.player.gender
  		dash_path
  	else
  		flash[:error] = "Please update your account info below!"
  		profile_path
  	end
  	
  end

end
