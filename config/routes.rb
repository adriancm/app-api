Rails.application.routes.draw do
  use_doorkeeper
  mount API::Base => '/api'
  resources :developers, only: [:index] do
    collection do
      get :o2c
      get :authorize
    end
  end

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'users#profile', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index], as: 'readme', path: 'readme'
  resources :users, only: [:show]
  resources :messages, only: [:create, :destroy]

  get 'profile', to: 'users#profile', as: 'profile'
  post 'follow', to: 'follows#create', as: 'follow'
  delete 'unfollow/:id', to: 'follows#destroy', as: 'unfollow'
  get 'followers', to: 'users#followers'
  get 'followings', to: 'users#followings'
end
