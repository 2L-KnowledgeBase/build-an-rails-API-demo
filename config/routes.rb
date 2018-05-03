Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	namespace :api do
		namespace :v1 do
			resources :users, only: [:index, :create, :show, :update, :destroy], :defaults => { :format => 'json' }
			resources :sessions, only: [:create], :defaults => { :format => 'json' }
			scope path: '/user/:user_id' do
				resources :microposts, only: [:index], :defaults => { :format => 'json' }
			end
		end
	end

end
