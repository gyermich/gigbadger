Badger::Application.routes.draw do

  post '/rate', to: 'rater#create', as:'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"




  patch "/tasks/:id/", to: "tasks#post", as: "post"
  post "/tasks/:id/complete", to: "tasks#complete", as: "complete"
  get "/users/:id/profile", to: "users#profile", as: "user_profile"

  get "/tasks/:id/offers"       => "tasks#offers",  as: :offers


  resources :categories
  resources :tasks do
    get :reset_filterrific, :on => :collection
  end

  get "messages/inbox"          => "messages#inbox"
  get "messages/sent"           => "messages#sent"
  get "messages/trash"          => "messages#trash"
  get "messages/reply"          => "messages#conversation"
  post "messages/reply"         => "messages#reply"
  post "messages/trash"         => "messages#move_to_trash",      as: :trash_message
  post "messages/delete"        => "messages#delete_from_trash",  as: :delete_message
  resources :messages

  
  resources :users

  put "/badgers"        => "user_tasks#check_badger",   as: :check_badger
  post "accept"         => "user_tasks#accept_offer",   as: :accept
  resources :user_tasks

end
