Badger::Application.routes.draw do


  root "welcome#index"

  get "welcome/index"
  get "session/create"
  get "session/destroy"
  get "session/destroy"
  # get "/login", to: "users#new"
  # post "in", to: "session#create",     as: "log_in"
  # delete "logout", to: "session#destroy", as: "logout"

  post "login"  => "session#create",     :as => "login"
  get "logout" => "session#destroy", :as => "logout"
  get "signup" => "users#new",       :as => "signup"

  resources :categories
  resources :tasks
  resources :users
  # resources :session


end
