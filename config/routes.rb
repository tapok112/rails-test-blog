Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments
  end
  root 'posts#index'
  get '/user_posts' => 'posts#user_posts_list', :as => :user_posts
end
