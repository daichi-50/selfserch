Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:show, :index] do
    member do
      get :favorites
    end
    
  end

  mount ActionCable.server => '/cable'
  root "tops#index"

  resources :posts do
    resources :messages, only: [:create]
    resources :favorites, only: [:create, :destroy]
    get :autocomplete_user_username, :on => :collection
    get :autocomplete_post_title_and_description_and_user_username, :on => :collection
    get 'search_users', to: 'users#search'
  end
  resources :transfers, only: :create
  get 'search_users', to: 'users#search'
end
