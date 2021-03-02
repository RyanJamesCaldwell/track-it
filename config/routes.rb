Rails.application.routes.draw do
  resources :projects
  root to: 'static_pages#home'
end
