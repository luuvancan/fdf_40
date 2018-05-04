Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :products
  end
end
