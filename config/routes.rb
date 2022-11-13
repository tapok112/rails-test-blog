Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :posts do
    resources :comments
  end

  root 'posts#index'
  get '/user_posts' => 'posts#user_posts_list', :as => :user_posts
end
