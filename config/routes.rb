Badger::Application.routes.draw do

  post '/rate', to: 'rater#create', as:'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"

  patch "/tasks/:id/", to: "tasks#post", as: "post"
  post "/tasks/:id/complete", to: "tasks#complete", as: "complete"
  get "/users/:id/profile", to: "users#profile", as: "user_profile"

  resources :categories
  resources :tasks do
    get :reset_filterrific, :on => :collection
  end
  resources :users
  resources :user_tasks
end
