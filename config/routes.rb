Rails.application.routes.draw do
  resources :projects do
    resources :issues, only: [:show]
  end
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: 'static_pages#home'
end
