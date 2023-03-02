Rails.application.routes.draw do
  get 'games_users/index'
  get 'games_users/show'
  get 'games_users/new'
  get 'games_users/create'
  get 'games_users/edit'
  get 'games_users/update'
  get 'games_users/destroy'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :cards
  resources :games
  resources :games_users
  resources :dealts
  resources :turns

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"
end
