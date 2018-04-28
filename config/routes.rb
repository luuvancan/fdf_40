Rails.application.routes.draw do
  namespace :admin do
  resources :categories
  end
  root "static_pages#home"
  get "static_pages/home"
end
