Rails.application.routes.draw do
  resources :forecasts, only: [:index, :create, :destroy]
  devise_for :users
  root to: 'forecasts#index'
end
