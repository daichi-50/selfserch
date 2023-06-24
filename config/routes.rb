Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  mount ActionCable.server => '/cable'
  root "tops#index"

  resources :users, only: [:new, :create, :show]
  resource :user_session, only: [:new, :create, :destroy]
  resources :posts do
    resources :messages, only: [:create]
  end
  resources :transfers, only: :create
  get 'search_users', to: 'users#search'
end
