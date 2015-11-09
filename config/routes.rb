Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :charges
  get 'register_cc', to: 'charges#new'
  get 'payment', to: 'charges#payment'
  post 'payment', to: 'charges#pay'
  post 'pay', to: 'charges#pay'
end
