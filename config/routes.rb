Badger::Application.routes.draw do

  root "tasks/index"

  get "session/create"
  get "session/destroy"

  resources :categories
  resources :tasks
  resources :users


end
