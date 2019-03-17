Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  devise_for :users, controllers: {
      registrations: "users/registrations"
  }

  resources :articles, except: [:create]
  get 'articles/:id/preview', to:'articles#preview'

  resources :comments, only: %i[create destroy]

  get 'admin', to: 'admin#index'

  devise_scope :user do
    get 'my_page', to: 'users/registrations#my_page'
  end
end