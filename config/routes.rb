Shaoxingjie::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :groups do
    member do
      get :join
      get :leave
      get :group_user
      get :new_topic
      post :create_topic
    end
    collection do
      get :my_group
    end
  end
  match "/groups/:gid/tag/:tid", :controller => 'groups', :action => 'tag', :as => :tag_group
  match "/groups/:gid/tags", :controller => 'groups', :action => 'tags', :as => :tags_group
  match "/groups/:gid/topic/:tid", :controller => 'groups', :action => 'topic', :as => :topic_group

  match "/topics/forum(:forum_id)" => "topics#tforum", :requirements => {:forum_id => /\d+/}, :as => "tforum"
  match "/topics/forum(:forum_id)/new" => "topics#new", :requirements => {:forum_id => /\d+/}, :as => "new_tforum"

  resources :forums
  resources :topics
  namespace :admin do
    root :to => "home#index"
    resources :groups do
      collection do
        get "q", :action => :search
      end
    end
  end
end
