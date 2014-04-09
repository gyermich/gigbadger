Badger::Application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"

  patch "/tasks/:id/"      => "tasks#post", :as => "post"

  resources :categories
  resources :tasks do
    get :reset_filterrific, :on => :collection
  end
  resources :users
  resources :user_tasks
end
