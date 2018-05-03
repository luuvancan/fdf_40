Rails.application.routes.draw do
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
  end

  namespace :public do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
  end
end
