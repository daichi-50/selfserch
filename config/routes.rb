Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:show, :index] do
    get :favorites, on: :collection
  end

  mount ActionCable.server => '/cable'
  root "tops#index"

  resources :posts do
    resources :messages, only: [:create]
    resources :favorites, only: [:create, :destroy]
  end
  resources :transfers, only: :create
  get 'search_users', to: 'users#search'
end
