Rails.application.routes.draw do
  resources :messages
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

  resources :users, only: [:index], as: 'readme'
  resources :users, only: [:show] do
    member do
      get :profile
    end
  end

end
