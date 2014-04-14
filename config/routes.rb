Badger::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root "welcome#index"
  get "welcome/index"


  post '/rate',               to: 'rater#create',                as: :rate
  patch "/tasks/:id/",        to: "tasks#post",                  as: :post
  post "/tasks/:id/complete", to: "tasks#complete",              as: :complete
  get "/tasks/:id/offers",    to: "tasks#offers",                as: :offers
  get "/users/:id/profile",   to: "users#profile",               as: :user_profile
  get "messages/inbox",       to: "messages#inbox"
  get "messages/sent",        to: "messages#sent"
  get "messages/trash",       to: "messages#trash"
  get "messages/reply",       to: "messages#conversation"
  post "messages/reply",      to: "messages#reply"
  post "messages/trash",      to: "messages#move_to_trash",      as: :trash_message
  post "messages/delete",     to: "messages#delete_from_trash",  as: :delete_message
  put "/badgers",             to: "user_tasks#check_badger",     as: :check_badger
  post "accept",              to: "user_tasks#accept_offer",     as: :accept


  resources :categories
  resources :messages
  resources :users
  resources :user_tasks

  resources :tasks do
    get :reset_filterrific, :on => :collection
  end
end
