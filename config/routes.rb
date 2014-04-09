Badger::Application.routes.draw do

  devise_for :users

  root "welcome#index"
  get "welcome/index"

  patch "/tasks/:id/"      => "tasks#post", :as => "post"

  resources :categories
  resources :tasks
  resources :users
  resources :user_tasks
end
