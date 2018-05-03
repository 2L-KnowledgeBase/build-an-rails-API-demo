class ApplicationController < ActionController::Base
	# https://stackoverflow.com/questions/43356105/actioncontrollerinvalidauthenticitytoken-rails-5-devise-audited-papertra
	#protect_from_forgery prepend: true
end
