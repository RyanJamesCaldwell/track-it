Rails.application.routes.draw do
  resources :projects do
    resources :issues, only: [:show]
    resources :membership_requests, only: [:index, :create, :update]
  end
  resources :issues, only: [:index, :create, :new, :edit, :update, :destroy]
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: 'static_pages#home'
end
