Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :products
  end
  namespace :public do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
  end
end
