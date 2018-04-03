Rails.application.routes.draw do
  resources :products
  devise_for :users
  resources :users, except: [:show, :new]

  root to: 'products#index'
end
