# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TennisBook::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app23081908@heroku.com',
  :password       => '6sw3lfjw',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
