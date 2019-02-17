Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :articles

  get 'authenticate', to:'home#login'
  get 'mypage', to: 'users#me'
end