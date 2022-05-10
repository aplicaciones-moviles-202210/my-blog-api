Rails.application.routes.draw do
  scope path: '/api' do
    api_version(module: 'Api::V1', path: { value: 'v1' }, defaults: { format: 'json' }) do
      resources :posts, only: [:index, :show, :create]
      resources :comments, only: [:show, :create]
      post "/login", to: "users#login"
      post "/signup", to: "users#create"
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
