Shaoxingjie::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  if Rails.env.development? 
    match "/images/*path" => "gridfs#serve"
  end
end
