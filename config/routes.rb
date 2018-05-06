Rails.application.routes.draw do

  namespace :admin do
  resources :categories
  end

  root "static_pages#home"
  resources :products
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
end
