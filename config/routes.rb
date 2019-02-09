Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'articles#index' ログイン状態でリダイレクトを行うようにする
  resources :articles
end
