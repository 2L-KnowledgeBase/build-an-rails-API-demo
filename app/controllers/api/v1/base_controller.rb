class Api::V1::BaseController < ApplicationController
	
	include Pundit

	rescue_from Pundit::NotAuthorizedError, with: :deny_access

	# disable CSRF token
	protect_from_forgery with: :null_session

	# disable cookies (no set-cookies header in response)
	before_action :destroy_session

	# disable the CSRF token
	skip_before_action :verify_authenticity_token

	attr_accessor :current_api_user

	def destroy_session
		request.session_options[:skip] = true
	end

	def api_error(opts = {})
		#render nothing: true, status: opts[:status]
		render body: nil, status: opts[:status]

	end

	def authenticate_user!
		token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
		
		api_user_email = options.blank?? nil : options[:email]
		api_user = api_user_email && ApiUser.find_by(email: api_user_email) 
		
		if api_user && ActiveSupport::SecurityUtils.secure_compare(api_user.authentication_token, token)
			request_endpoint = request.fullpath.split("?")[0]
			api_endpoint = api_user.api_endpoints.find_by(url:request_endpoint)
			
			if api_endpoint
				api_permission = api_user.api_permissions.find_by(api_endpoint_id:api_endpoint.id)
				api_permission.increment!(:request_times)
				api_user.request_histories.create(api_user_id:api_user.id,api_endpoint_id:api_endpoint.id,request_parameter:URI.unescape(request.fullpath))

				self.current_api_user = api_user
			else
				return deny_access
			end
		else
			return unauthenticated!
		end
	end

	def unauthenticated!
		api_error(status: 401)
	end

	def deny_access
		api_error(status: 403)
	end

	def paginate(resource)
		resource = resource.page(params[:page] || 1)
		if params[:per_page]
			resource = resource.per(params[:per_page])
		end
		
		return resource
	end

end
