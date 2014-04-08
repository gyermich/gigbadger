Badger::Application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"

  resources :categories
  resources :tasks
  resources :users
end
