json.session do
	json.(@api_user, :id, :name)
	json.token @api_user.authentication_token
end
