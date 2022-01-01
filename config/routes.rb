Rails.application.routes.draw do
  get 'static_pages/top'
  get 'static_pages/about'
  get 'static_pages/faq'
  get 'static_pages/inquiry'
  get 'static_pages/policy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#hello"
end
