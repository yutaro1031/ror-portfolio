Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :articles

  get 'mypage', to: 'users#me'
end