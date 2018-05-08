class Api::V1::SessionsController < Api::V1::BaseController

	def create
		@api_user = ApiUser.find_by(email: create_params[:email])
		if @api_user && @api_user.authenticate(create_params[:password])
			@api_user.reset_auth_token!	
			self.current_api_user = @api_user
		else
			return api_error(status: 401)
		end
	end

	private

	def create_params
		params.require(:user).permit(:email, :password)
	end 	

end
