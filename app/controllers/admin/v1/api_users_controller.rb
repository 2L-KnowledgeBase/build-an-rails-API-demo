class Admin::V1::ApiUsersController < ApplicationController

	include ActionView::Helpers::TextHelper		
	
	before_action :require_login
	
	def index
		@user = User.find(params[:user_id])
		@api_users = @user.api_users

		data = @api_users.joins(:api_permissions).select('email,api_endpoint_id,request_times')

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title(text: "API Request Statistic")
			f.xAxis(categories: data.map{|d| d.email}.uniq )
			
			data.group_by{|d| d.api_endpoint_id}.each_with_index do |(k,v),index|
		  		f.series(name: ApiEndpoint.find(k).public_name, yAxis: index, data:v.map{|d| d.request_times}) 
			end	
			
			f.yAxis [
				{title: {text: "request times"}, minTickInterval: 1 },
				{title: {text: "@copyright cscs"}, opposite: true, minTickInterval: 1}
			]

	
			f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
			f.chart({defaultSeriesType: "column"})
		end
		
		@chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
			f.global(useUTC: false)
			f.chart(
				backgroundColor: {
				  linearGradient: [0, 0, 500, 500],
				  stops: [
				    [0, "rgb(255, 255, 255)"],
				    [1, "rgb(240, 240, 255)"]
				  ]
				},
				borderWidth: 2,
				plotBackgroundColor: "rgba(255, 255, 255, .9)",
				plotShadow: true,
				plotBorderWidth: 1
			)
			f.lang(thousandsSep: ",")
			f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
		end
	end 

	def new
		@api_user = ApiUser.new
		@user = User.find(params[:user_id])
	end

	def create
		@user = User.find(params[:user_id])
		@api_user = @user.api_users.create(api_user_params)		
		if @api_user.valid?
			if params[:allowed_api_endpoints].nil?
				@error_msg = simple_format('Please Select At Least One API Endpoint!')
				render 'shared/error'
			else
				@api_user.save

				params[:allowed_api_endpoints].each do |e|
					@api_permission = ApiPermission.new(api_user_id: @api_user.id, api_endpoint_id: e)
					@api_permission.save
				end
				
				redirect_to admin_v1_user_api_users_path
			end
		else
			@error_msg = simple_format(@api_user.errors.messages.to_s)
			render 'shared/error'
		end

	end

	def edit
		@user = User.find(params[:user_id])
		@api_user = ApiUser.find(params[:id])
	end

	def update
		@api_user = ApiUser.find(params[:id])
		@api_user.update(api_user_params)
		if @api_user.valid?
			if params[:allowed_api_endpoints].nil?
				@error_msg = simple_format('Please Select At Least One API Endpoint!')
				render 'shared/error'
			else
				@api_user.save
				what_you_need = params[:allowed_api_endpoints].map{|e| e.to_i}
				already_have = @api_user.api_endpoints.ids
				(already_have - what_you_need).each do |api_endpoint_id|
					@api_user.api_permissions.find_by(api_endpoint_id:api_endpoint_id).destroy
				end
				
				(what_you_need - already_have).each do |api_endpoint_id|
					@api_permission = ApiPermission.new(api_user_id: @api_user.id, api_endpoint_id: api_endpoint_id)
					@api_permission.save
				end

				redirect_to admin_v1_user_api_users_path
			end
		else
			@error_msg = simple_format(@api_user.errors.messages.to_s)
			render 'shared/error'
		end
	end

	def show
		@api_user = ApiUser.find(params[:id])

	end

	def destroy
		@api_user = ApiUser.find(params[:id])
		@api_user.destroy
		redirect_to admin_v1_user_api_users_path
	end

	private
	
	def api_user_params
		params.require(:api_user).permit(:name,:email,:password)	
	end
   	
	def require_login
		if session[:user_id].to_s != params[:user_id].to_s
			redirect_to '/admin/v1'
		end	
	end
	
end
