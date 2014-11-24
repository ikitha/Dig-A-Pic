ActionMailer::Base.smtp_settings = {
	:address   => "smtp.mandrillapp.com",
	:port      => 25, # ports 587 and 2525 are also supported with STARTTLS
	:enable_starttls_auto => true, # detects and uses STARTTLS
	:user_name => ENV["mandrill_username"],
	:password  => ENV["mandrill_key"], # SMTP password is any valid API key
	:authentication => 'login', # Mandrill supports 'plain' or 'login'
}