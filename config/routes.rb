Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :articles

  get 'mypage', to: 'users#me'
  get 'admin', to: 'admin#index'
  get 'regist_admin_user', to: 'admin#sign_up'
end