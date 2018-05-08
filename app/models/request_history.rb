class RequestHistory < ApplicationRecord

	belongs_to :api_user
	belongs_to :api_endpoint

end
