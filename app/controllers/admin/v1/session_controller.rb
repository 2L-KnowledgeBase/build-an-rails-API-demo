class Admin::V1::SessionController < ApplicationController

	include ActionView::Helpers::TextHelper

	def login
		if session[:user_id]
			@user=User.find(session[:user_id])
			redirect_to admin_v1_user_api_users_path(@user)	
		end
	end

	def verify
		@user = User.find_by(email: verify_params[:email])
		if @user && @user.authenticate(verify_params[:password])
			session[:user_id]=@user.id
			redirect_to admin_v1_user_api_users_path(@user)	
		else
			@error_msg=simple_format("Invalid email&password combination!")	
			render 'shared/error'	
		end
	end

	private 

	def verify_params
		params.require(:session).permit(:email, :password)
	end

end
