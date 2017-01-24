Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:create, :destroy]

  get    '/login',    to: 'user_sessions#new'
  post   '/login',    to: 'user_sessions#create'
  get    '/logout',   to: 'user_sessions#destroy'
  delete '/logout',   to: 'user_sessions#destroy'
  get    '/confirm',  to: 'user_sessions#confirm'
  put    '/validate', to: 'user_sessions#validate'
end
