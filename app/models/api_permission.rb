class ApiPermission < ApplicationRecord
	
	belongs_to :api_user
	belongs_to :api_endpoint
	has_many :api_histories

end
