Rails.application.routes.draw do

  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end

  # wanted to add API subdomain  as it's best practice
  # to balance load but couldn't test with localhost
  # :path => "/", :constraints => {:subdomain => "api"},
  namespace :api, defaults: {format: 'json'} do
     namespace :v1 do
      resource :cart, only: [:show, :add, :remove]
      resources :products
    end
  end

  devise_for :users
  resources :products

  root "products#index"
end
