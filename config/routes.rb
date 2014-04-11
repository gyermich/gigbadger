Badger::Application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"


  put "/badgers"             => "user_tasks#check_badger", as: :check_badger
  patch "/tasks/:id/"      => "tasks#post", :as => "post"

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

  resources :messages

  
  resources :users


  resources :user_tasks

end
