Badger::Application.routes.draw do

  post '/rate', to: 'rater#create', as:'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"


  put "/badgers"             => "user_tasks#check_badger", as: :check_badger

  patch "/tasks/:id/", to: "tasks#post", as: "post"
  post "/tasks/:id/complete", to: "tasks#complete", as: "complete"
  get "/users/:id/profile", to: "users#profile", as: "user_profile"


  resources :categories
  resources :tasks do
    get :reset_filterrific, :on => :collection
  end

  resources :badgers

  get "messages/inbox"    => "messages#inbox"
  get "messages/sent"     => "messages#sent"
  get "messages/trash"    => "messages#trash"
  get "messages/reply"    => "messages#conversation"
  post "messages/reply"   => "messages#reply"
  post "messages"         => "messages#move_to_trash",      as: :trash_message
  # post "messages"         => "messages#delete_conversation"

  resources :messages

  
  resources :users


  resources :user_tasks

end
