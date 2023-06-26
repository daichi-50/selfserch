Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'
  root "tops#index"

  resources :users, only: [:show, :index]
  resources :posts do
    resources :messages, only: [:create]
  end
  resources :transfers, only: :create
  get 'search_users', to: 'users#search'
end
