Rails.application.routes.draw do
  devise_for :admins
  resources :categories
  resources :participants
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }
  resources :users, only: [:create, :show, :update, :destroy]
  resources :events
  post '/login', to: 'sessions#create'
  post '/register', to: 'users#create'
  delete '/logout' , to: 'sessions#destroy'

  namespace :admin do
    get "categories/index"
    get "categories/create"
    get "categories/update"
    get "categories/destroy"
    get '/dashboard', to: 'dashboard#index'
    resources :events, only: [:index, :show, :update, :destroy]
    resources :users, only: [:index, :show, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
