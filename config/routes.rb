Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :categories
  devise_for :users

  root 'articles#index'
  
  resources :articles
  resources :comments
end
