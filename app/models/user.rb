class User < ApplicationRecord

	has_many :api_users, dependent: :destroy
	
	has_secure_password

end
