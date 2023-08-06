Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: %i[show index] do
    member do
      get :favorites
    end
  end

  mount ActionCable.server => '/cable'
  root 'tops#index'

  resources :notifications, only: :index
  delete 'notifications/destroy_all', to: 'notifications#destroy_all', as: :destroy_all_notifications
  resources :posts do
    resources :messages, only: [:create]
    resources :favorites, only: %i[create destroy]
    get :autocomplete_user_username, on: :collection
    get :autocomplete_post_title_and_description_and_user_username, on: :collection
    get 'search_users', to: 'users#search'
  end
  resources :transfers, only: :create
  get 'search_users', to: 'users#search'
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
