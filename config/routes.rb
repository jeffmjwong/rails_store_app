Rails.application.routes.draw do
  resources :purchases
  resources :carts, except: [:index, :new, :edit, :update, :destroy]
  resources :products
  devise_for :users
  resources :users, except: [:show, :new]

  root to: 'home#index'
end
