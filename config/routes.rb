Rails.application.routes.draw do
  get 'sessions/new'
  #get 'users/new'
  get '/signup', to:'users#new'
  post '/signup', to: 'users#create'

  #login
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#hello"
  resources :users
end
