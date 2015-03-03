Rails.application.routes.draw do

  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end

  namespace :api do
    resource :cart, only: [:show]
    resources :products
  end

  devise_for :users
  resources :products

  root "products#index"
end
