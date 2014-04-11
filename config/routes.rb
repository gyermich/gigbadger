Badger::Application.routes.draw do


  devise_for :users, controllers: { registrations: 'users/registrations' }

  root "welcome#index"
  get "welcome/index"

  post '/rate', to: 'rater#create', as:'rate'
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
