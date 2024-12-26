Rails.application.routes.draw do
	get 'lifetimes/index'

	root 'common_pages#index'

	get '/search', to: 'common_pages#search'
	get '/promo', to: 'common_pages#promo'
	get '/about', to: 'common_pages#about'
	get '/profile', to: 'users#single'
	get '/featured', to: 'lifetimes#featured'
	get '/lifetimes/:id/(:year)', to: 'lifetimes#single', as: :single_lifetime

	namespace :api do
		get '/lifetimes/', to: 'lifetimes#index'
		get '/lifetimes/:id/', to: 'lifetimes#single'
	end

	resources :lifetimes, only: [:update] do
		member do
			patch ':year', to: 'lifetimes#update_single'
		end
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
			scope '/admin' do
				root to: 'admin#index'
			end

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
