Diaspora::Application.routes.draw do |map|
  resources :blogs
  resources :bookmarks
  resources :people
  resources :users
  resources :status_messages
  resources :comments
  resources :requests
  resources :photos
  resources :albums

  match "/images/files/*path" => "gridfs#serve"
  
  match 'warzombie', :to => "dev_utilities#warzombie"
  match 'zombiefriends', :to => "dev_utilities#zombiefriends"
  match 'zombiefriendaccept', :to => "dev_utilities#zombiefriendaccept"

  #routes for devise, not really sure you will need to mess with this in the future, lets put default,
  #non mutable stuff in anohter file
  devise_for :users, :path_names  => {:sign_up  => "signup", :sign_in  => "login", :sign_out  => "logout"}
   match 'login', :to => 'devise/sessions#new', :as => "new_user_session"
   match 'logout', :to  => 'devise/sessions#destroy', :as => "destroy_user_session"
   #match 'signup', :to => 'devise/registrations#new', :as => "new_user_registration"
  resources :users
  
  
  #public routes
  match 'receive/users/:id',     :to => 'publics#receive'
  match '.well-known/host-meta',:to => 'publics#host_meta'
  match 'webfinger',            :to => 'publics#webfinger'
  match 'hcard',                :to => 'publics#hcard'
          
  #root
  root :to => 'dashboards#index'
end
