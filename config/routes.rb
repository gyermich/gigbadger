Badger::Application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  root "welcome#index"
  get "welcome/index"


  put "/badgers"             => "badgers#check_badger", as: :check_badger
  patch "/tasks/:id/"      => "tasks#post", :as => "post"

  resources :categories
  resources :tasks do
    get :reset_filterrific, :on => :collection
  end

  resources :badgers

  
  resources :users do
    get "messages/inbox"    => "messages#inbox"
    get "messages/sent"     => "messages#sent"
    get "messages/trash"    => "messages#trash"
    resources :messages
  end


  resources :user_tasks

end
