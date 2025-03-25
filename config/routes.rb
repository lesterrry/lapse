Rails.application.routes.draw do
	root 'common_pages#index'

	namespace :admin do
		resources :lifetimes
		resources :passkeys
		resources :periods
		resources :subscriptions
		resources :users

		root to: 'users#index'
	end

	get '/search', to: 'common_pages#search'
	get '/promo', to: 'common_pages#promo'
	get '/about', to: 'common_pages#about'
	get '/profile', to: 'users#single'
	get '/featured', to: 'lifetimes#featured'

	namespace :api do
		get '/lifetimes/', to: 'lifetimes#index'
		get '/lifetimes/:id/', to: 'lifetimes#single'

		post '/login', to: 'users#login'
		post '/signup', to: 'users#signup'
	end

	get '/lifetimes/new', to: 'lifetimes#new', as: :new_lifetime

	resources :lifetimes, only: %i[create destroy] do # update logic is implemented below
		member do
			patch ':year', to: 'lifetimes#update_single'
			get '(:year)', to: 'lifetimes#single', as: :single
		end

		resources :comments, only: %i[create destroy]
		resources :likes, only: %i[create destroy]
	end

	resources :subscriptions, only: [:create]

	devise_for :users, controllers: {
		registrations: 'users/registrations',
		sessions: 'users/sessions'
	}

	devise_scope :user do
		get 'me', to: 'users/profiles#single', as: :my_profile

		post 'sign_up/new_challenge', to: 'users/registrations#new_challenge', as: :new_user_registration_challenge
		post 'sign_in/new_challenge', to: 'users/sessions#new_challenge', as: :new_user_session_challenge

		post 'reauthenticate/new_challenge', to: 'users/reauthentication#new_challenge', as: :new_user_reauthentication_challenge
		post 'reauthenticate', to: 'users/reauthentication#reauthenticate', as: :user_reauthentication

		namespace :users do
			resources :passkeys, only: %i[index create destroy] do
				collection do
					post :new_create_challenge
				end

				member do
					post :new_destroy_challenge
				end
			end
		end
	end
end
