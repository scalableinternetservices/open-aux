Rails.application.routes.draw do
  #get 'users/new'
  get '/signup', to:'users#show'
  post '/signup', to: 'users#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#hello"
  resources :users
end
