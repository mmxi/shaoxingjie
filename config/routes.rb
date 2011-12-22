Shaoxingjie::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:index, :show]

  if Rails.env.development? 
    match "/images/*path" => "gridfs#serve"
  end

  match "/topics/forum(:forum_id)" => "topics#tforum", :requirements => {:forum_id => /\d+/}, :as => "tforum"
  match "/topics/forum(:forum_id)/new" => "topics#new", :requirements => {:forum_id => /\d+/}, :as => "new_tforum"

  resources :forums
  resources :topics
  namespace :admin do
    root :to => "home#index"
    resources :forums
  end
end
