Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'products#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/profile', to: 'users#edit', as: :edit_user
  patch '/profile', to: 'users#update', as: :user
  post '/become_buyer', to: 'users#become_buyer'
  post '/become_seller', to: 'users#become_seller'

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products
  resources :orders, only: [:create]
end