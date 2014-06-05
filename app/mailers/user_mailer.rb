class UserMailer < ActionMailer::Base
  default from: "invite@tennisbook.com"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def send_invite(player, invite_email)
  	if invite_email =~ VALID_EMAIL_REGEX
  		@player = player
  		mail(to: invite_email, :subject => "#{player.real_name} has invited you to join TennisBook!", from: "TennisBook <invite@tennisbook.com>")
  	end
  end

end
	