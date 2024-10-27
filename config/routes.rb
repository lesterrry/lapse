Rails.application.routes.draw do
  get 'users/single'
  get 'lifetimes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'static_pages#index'

  get '/search', to: 'static_pages#search'
  get '/profile', to: 'users#single'
  get '/featured', to: 'lifetimes#featured'
  get '/lifetime', to: 'lifetimes#single'
end
