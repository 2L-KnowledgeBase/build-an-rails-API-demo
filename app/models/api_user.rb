class ApiUser < ApplicationRecord

	belongs_to :user
	has_many :api_permissions, dependent: :destroy
	has_many :api_endpoints, through: :api_permissions
	has_many :request_histories

	has_secure_password
	before_create :generate_authentication_token

	def generate_authentication_token
		loop do
			self.authentication_token = SecureRandom.base64(64)
			break if !ApiUser.find_by(authentication_token: authentication_token)
		end
	end

	def reset_auth_token!
		generate_authentication_token
		save
	end

end
