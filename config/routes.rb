Rails.application.routes.draw do
  get 'playlist/show'
  get 'sessions/new'
  #get 'users/new'
  get '/signup', to:'users#new'
  post '/signup', to: 'users#create'

  #login
  get    '/login',   to: 'sessions#new'
  # post   '/login',   to: 'sessions#create'
  post     '/login', to: 'playlist#new'
  delete '/logout',  to: 'sessions#destroy'

  #playlist
  post    '/createPlaylist',   to: 'playlist#create'
  resources :playlist
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#home"
  resources :users
end
