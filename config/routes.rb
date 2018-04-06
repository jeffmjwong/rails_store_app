Rails.application.routes.draw do
  devise_for :users
  resources :users, except: [:show, :new, :create]
  resources :products
  resources :charges
  resources :carts, except: [:index, :new, :edit, :update, :destroy]
  resources :purchases
  get '/charges/new/:id', to: 'charges#new', as: 'new_charges_path'
  get '/home', to: 'home#index', as: 'home_path'

  root to: 'prelogin#index'
end
