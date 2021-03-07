Rails.application.routes.draw do
  resources :projects do
    resources :membership_requests, only: %i[index create update]
  end
  resources :issues do
    resources :comments, only: %i[create destroy]
  end
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  root to: 'static_pages#home'
end
