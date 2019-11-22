Rails.application.routes.draw do
  get 'playlist/show'
  get 'guests/new'
  get 'sessions/new'
  #get 'users/new'
  get '/signup', to:'users#new'
  post '/signup', to: 'users#create'
  get '/user-playlists', to: 'users#user_playlists'
  #login
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  #post     '/login', to: 'playlist#new'
  get    '/logout',  to: 'sessions#destroy'
  delete '/logout',  to: 'sessions#destroy'

  #playlist
  get   '/playlist',   to: 'playlist#new'
  post  '/playlist',   to: 'playlist#create'
  get   '/dashboard',  to: 'playlist#show'
  get   '/playlist/get-key', to:'playlist#get_playlist_key'
  get   'playlist/decrypt-key', to:'playlist#decrypt_key'
  get   'playlist/get-songs', to:'playlist#get_songs'
  post  'playlist/route-playlist', to: 'playlist#route_playlist'
  resources :playlist

  #guest
  get    '/join',    to: 'guests#new'
  post   '/linking', to: 'guests#change'

  #song
  get '/search', to: 'song#search'
  get '/searchResult', to: 'song#show'
  # get '/searchResults', to: 'song#'
  post '/song', to: 'song#create'
  post '/song/up-vote', to: 'song#up_vote'
  post '/song/down-vote', to: 'song#down_vote'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#home"
  resources :users
end
