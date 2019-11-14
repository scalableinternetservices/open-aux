Rails.application.routes.draw do
  get 'playlist/show'
  get 'guests/new'
  get 'sessions/new'
  #get 'users/new'
  get '/signup', to:'users#new'
  post '/signup', to: 'users#create'

  #login
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  #post     '/login', to: 'playlist#new'
  delete '/logout',  to: 'sessions#destroy'

  #playlist
  get '/playlist',   to: 'playlist#new'
  post    '/createPlaylist',   to: 'playlist#create'
  resources :playlist
  #guest
  get    '/join',    to: 'guests#new'

  #song
  get '/search', to: 'song#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#home"
  resources :users
end
