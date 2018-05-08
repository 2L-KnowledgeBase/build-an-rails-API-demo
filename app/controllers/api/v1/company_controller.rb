class Api::V1::CompanyController < Api::V1::BaseController

	before_action :authenticate_user!
	
	def query
		query_hbase(query_params)
	end


	def query_hbase(company_nm)
		#puts "#{BuildApiDemo::Application.config.hbase_rest_endpoint}/portal:company_gs/#{query_params[:company_name]}/data:json"
		response = RestClient.get URI.escape("#{BuildApiDemo::Application.config.hbase_rest_endpoint}/portal:company_gs/#{query_params[:company_name]}/data:json")
		render :json => response.body 
	end

	private

	def query_params
		params.permit(:company_name)
	end

end
