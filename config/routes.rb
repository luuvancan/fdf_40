Rails.application.routes.draw do

  devise_for :users
  root "home#index"

  namespace :authentication do
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
  end

  namespace :admin do
    resources :categories
    resources :products
    resources :users
    resources :orders
    resources :order_details, only: :show
    resources :comments, only: [:index, :destroy]
    post "/products/search/", to: "products#search"
    get "/myorder", to: "orders#user_order"
  end

  namespace :public do
    get "/home", to: "static_pages#home"
    get "/category/:id", to: "products#index"
    resources :products
    resource :cart, only: [:show]
    post "/add_cart", to: "order_details#create"
    post "/update_cart", to: "order_details#update"
    post "/delete_cart/:id", to: "order_details#destroy"
    post "/checkout", to: "orders#create"
    resources :comments
  end
end
