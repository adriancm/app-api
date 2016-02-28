Rails.application.routes.draw do
  use_doorkeeper
  mount API::Base => '/api'
  resources :developers, only: [:index] do
    collection do
      get :o2c
      get :authorize
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do
    authenticated :user do
      root 'landing#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

end
