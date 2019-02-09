Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index' #ログイン状態でリダイレクトを行うようにする
  resources :articles
  resources :users, only: %i[new create]

  get 'mypage', to: 'users#me'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end