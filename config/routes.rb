Badger::Application.routes.draw do


  root "welcome#index"

  get "welcome/index"
  get "session/create"
  get "session/destroy"
  get "session/destroy"

  post "login", "session#create",  as: "login"
  get "logout", "session#destroy", as: "logout"
  get "signup", "users#new",       as: "signup"

  resources :categories
  resources :tasks
  resources :users



end
