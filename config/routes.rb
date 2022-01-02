Rails.application.routes.draw do
  root "static_pages#top"
  get  '/top',    to: 'static_pages#top'
  get  '/about',   to: 'static_pages#about'
  get  '/faq',   to: 'static_pages#faq'
  get  '/inquiry', to: 'static_pages#inquiry'
  get  '/policy', to: 'static_pages#policy'
end
