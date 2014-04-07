Badger::Application.routes.draw do

  devise_for :users
  root "welcome#index"

  get "welcome/index"


  resources :categories
  resources :tasks
  resources :users
end
