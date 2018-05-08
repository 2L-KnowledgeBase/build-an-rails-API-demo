Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	namespace :api do
		namespace :v1 do
			resources :sessions, only: [:create], :defaults => { :format => 'json' }
			scope path: '/user/:user_id' do
				resources :microposts, only: [:index], :defaults => { :format => 'json' }
			end
			get '/company', to: 'company#query', :defaults => { :format => 'json' }
		end
	end

	namespace :admin do
		namespace :v1 do
			get '/', to: 'session#login'
			post '/', to: 'session#verify'

			resources :users do
				member do
					get 'logout'
				end
				resources :api_users do
					member do
						get 'disable'
					end
				end
			end
		end
	end

end
