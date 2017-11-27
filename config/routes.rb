Rails.application.routes.draw do
  resources :locations
  resources :homes, only: :index 
  devise_for :users
  root to: 'homes#index'
end
