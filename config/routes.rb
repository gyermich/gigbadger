Badger::Application.routes.draw do


  root "welcome#index"

  get "welcome/index"
  get "session/create"
  get "session/destroy"
  get "session/destroy"
  get "/login", to: "users#new", as: 'login'

  resources :categories
  resources :tasks
  resources :users


end
