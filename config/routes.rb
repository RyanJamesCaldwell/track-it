Rails.application.routes.draw do
  resources :projects do
    resources :issues, only: [:show]
  end
  root to: 'static_pages#home'
end
