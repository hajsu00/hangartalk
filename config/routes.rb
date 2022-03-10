Rails.application.routes.draw do
  get 'glider_flight_collection/new'
  get 'glider_flight_collection/create'
  get 'glider_initial_logs/new'
  get 'glider_initial_logs/create'
  get 'glider_initial_logs/show'
  get 'glider_initial_logs/edit'
  get 'glider_initial_logs/update'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root "static_pages#top"
  get  '/top', to: 'static_pages#top'
  get  '/about', to: 'static_pages#about'
  get  '/faq',   to: 'static_pages#faq'
  get  '/inquiry', to: 'static_pages#inquiry'
  get  '/policy', to: 'static_pages#policy'
  get  '/signup',     to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # post '/share_micropost/:id', to: 'microposts#share_micropost'
  # resources :users do
  #   collection do
  #     get :select_new_flight, :select_flight_log
  #   end
  # end
  resources :glider_flights do
    collection do
      get :new_from_groups
      post :create_from_groups
    end
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :account_activations,       only: [:edit]
  resources :password_resets,           only: [:new, :create, :edit, :update]
  resources :microposts,                only: [:new, :create, :show, :destroy]
  resources :relationships,             only: [:create, :destroy]
  resources :aeroplane_flights,         only: [:new, :create, :show, :index, :destroy]
  resources :glider_flights,            only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resources :groups,                    only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resources :glider_group_flights,      only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resources :glider_initial_logs,       only: [:new, :create, :show, :edit, :update, :destroy]
  resources :group_users,               only: [:create, :destroy]
  resources :glider_flight_collection,  only: [:new, :create]
  resources :glider_micropost_relationships,  only: [:new, :create]
  resources :reply_relationships,  only: [:new, :create]
  resources :share_relationships,  only: [:new, :create, :destroy]
  resources :like_relationships,  only: [:create, :destroy]
end
