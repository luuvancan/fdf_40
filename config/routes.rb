Rails.application.routes.draw do
  get 'product/show'

  namespace :admin do
  resources :categories
  end
  root "static_pages#home"
  resources :product
end
