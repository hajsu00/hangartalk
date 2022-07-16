Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'static_pages#top'
  get 'gliderflight_collection/new'
  get 'gliderflight_collection/create'

  resources :gliderflights do
    collection do
      get :new_from_groups
      post :create_from_groups
    end
  end
  resources :users do
    member do
      get :following, :followers
    end
    resources :licenses

    resources :licenses do
      resources :reccurent_histories
    end
  end

  resources :microposts do
    post :create_reply
    post :share_flight
  end
  resources :gliderflights
  resources :users,                     only: [:show]
  resources :microposts,                only: [:new, :create, :show, :index, :destroy]
  resources :relationships,             only: [:create, :destroy]
  resources :aeroplane_flights,         only: [:new, :create, :show, :index, :destroy]
  resources :groups,                    only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resources :glider_group_flights,      only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resources :glider_initial_logs,       only: [:new, :create, :show, :edit, :update, :destroy]
  resources :group_users,               only: [:create, :destroy]
  resources :gliderflight_collection,   only: [:new, :create]
  resources :gliderflight_microposts,   only: [:new, :create]
  resources :reply_relationships,       only: [:new, :create]
  resources :share_relationships,       only: [:new, :create, :destroy]
  resources :like_relationships,        only: [:create, :destroy]
end
