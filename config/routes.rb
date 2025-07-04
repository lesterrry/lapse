Rails.application.routes.draw do
	root 'common_pages#index'

	get '/locale/:locale', to: 'service#locale', as: :set_locale

	namespace :admin do
		resources :lifetimes
		resources :passkeys
		resources :periods
		resources :subscriptions
		resources :users

		root to: 'users#index'
	end

	# get '/featured', to: 'lifetimes#featured'

	namespace :api do
		get '/lifetimes/', to: 'lifetimes#index'
		get '/lifetimes/:id/', to: 'lifetimes#single'
		patch '/lifetimes/:id/', to: 'lifetimes#update_single'
		post '/lifetimes/:lifetime_id/comments', to: 'comments#create'
		post '/lifetimes/:lifetime_id/like', to: 'likes#create'
		delete '/lifetimes/:lifetime_id/like', to: 'likes#destroy'

		delete '/comments/:id', to: 'comments#destroy'

		post '/login', to: 'users#login'
		post '/signup', to: 'users#signup'

		get '/users/', to: 'users#index'
		get '/users/:id/lifetimes', to: 'users#lifetimes'
		get '/users/:id/', to: 'users#single'

		post '/subscribe', to: 'subscriptions#create'
	end

	get '/lifetimes/new', to: 'lifetimes#new', as: :new_lifetime
	get '/saved', to: 'savings#index', as: :saved_lifetimes

	resources :lifetimes, only: %i[create destroy] do # update logic is implemented below
		member do
			patch ':year', to: 'lifetimes#update_single'
			get '(:year)', to: 'lifetimes#single', as: :single
		end

		resources :comments, only: %i[create destroy]
		resources :likes, only: %i[create destroy]
		resources :savings, only: %i[create destroy]
	end

	resources :subscriptions, only: [:create]

	devise_for :users, controllers: {
		registrations: 'users/registrations',
		sessions: 'users/sessions'
	}

	devise_scope :user do
		get 'me', to: 'users/profiles#me', as: :my_profile
		get 'me/edit', to: 'users/profiles#edit', as: :edit_profile

		resources :followings, only: %i[create destroy]

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

			get ':id', to: 'profiles#single', as: :single_profile
			get ':id/followers', to: 'profiles#followers', as: :user_followers
			get ':id/followings', to: 'profiles#followings', as: :user_followings
			patch ':id', to: 'profiles#update_single', as: :update_single_profile
		end
	end
end
