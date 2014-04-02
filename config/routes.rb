Badger::Application.routes.draw do


  root "welcome#index"

  get "welcome/index"
  get "session/create"
  get "session/destroy"

  resources :categories
  resources :tasks
  resources :users


end
