Rails.application.routes.draw do
  resources :carts
  resources :products
  devise_for :users
  resources :users, except: [:show, :new]

  root to: 'home#index'
end
