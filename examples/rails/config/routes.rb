Rails.application.routes.draw do
  resources :users
  root 'application#index'
end