class Admin::V1::UsersController < ApplicationController

	def logout
		session.destroy
		redirect_to '/admin/v1'
	end

end
