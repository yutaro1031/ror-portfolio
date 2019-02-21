Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
      registrations: "users/registrations"
  }

  resources :articles

  #get 'mypage', to: 'users#me'
  get 'admin', to: 'admin#index'
  get 'regist_admin_user', to: 'admin#sign_up'

  devise_scope :user do
    get 'my_page', to: 'users/registrations#my_page'
  end
end