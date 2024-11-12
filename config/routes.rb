Rails.application.routes.draw do
	get 'users/single'
	get 'lifetimes/index'

	root 'common_pages#index'

	get '/search', to: 'common_pages#search'
	get '/promo', to: 'common_pages#promo'
	get '/about', to: 'common_pages#about'
	get '/profile', to: 'users#single'
	get '/featured', to: 'lifetimes#featured'
	get '/lifetimes/:id/(:year)', to: 'lifetimes#single', as: 'single_lifetime'

	resources :lifetimes, only: [:update] do
		member do
			patch ':year', to: 'lifetimes#update_single'
		end
	end

	resources :subscriptions, only: [:create]
end
