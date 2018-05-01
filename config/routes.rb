Rails.application.routes.draw do
  namespace :admin do
    resources :categories
  end
end
