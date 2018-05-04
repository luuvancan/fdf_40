Rails.application.routes.draw do

  namespace :admin do
  resources :categories
  end
  root "static_pages#home"
  resources :product
  resources :cart
end
