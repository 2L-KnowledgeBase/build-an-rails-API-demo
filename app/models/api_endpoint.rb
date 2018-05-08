class ApiEndpoint < ApplicationRecord

	has_many :api_permissions, dependent: :destroy
	has_many :api_users, through: :api_endpoints
	has_many :request_histories

end
