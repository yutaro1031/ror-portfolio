Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  devise_for :users, controllers: {
      registrations: "users/registrations"
  }

  resources :articles, except: [:create]

  get 'admin', to: 'admin#index'

  devise_scope :user do
    get 'my_page', to: 'users/registrations#my_page'
  end
end