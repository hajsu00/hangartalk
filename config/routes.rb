Rails.application.routes.draw do
  get 'sessions/new'
  root "static_pages#top"
  get  '/top',    to: 'static_pages#top'
  get  '/about',   to: 'static_pages#about'
  get  '/faq',   to: 'static_pages#faq'
  get  '/inquiry', to: 'static_pages#inquiry'
  get  '/policy', to: 'static_pages#policy'
  get  '/signup',     to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
