Badger::Application.routes.draw do

  devise_for :users
  # resources :users, only: [:index]
  root "welcome#index"

  get "welcome/index"


  resources :categories
  resources :tasks
  resources :users
end
