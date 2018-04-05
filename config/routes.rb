Rails.application.routes.draw do
  devise_for :users
  resources :users, except: [:show, :new, :create]
  resources :products
  resources :carts, except: [:index, :new, :edit, :update, :destroy]
  resources :purchases
  get '/home', to: 'home#index', as: 'home_path'

  root to: 'prelogin#index'
end
