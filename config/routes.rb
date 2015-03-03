Rails.application.routes.draw do
  get 'carts/show'

  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
  end

  devise_for :users
  resources :products

  root "products#index"
end
