Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  post '/login', to: 'sessions#create'
  post '/register', to: 'users#create'
  delete '/logout' , to: 'sessions#destroy'

  resources :categories
  resources :users, only: [:create, :show, :update, :destroy]

  resources :events do
    resources :participants, only: [:index, :create]
  end

  resources :participants, only: [:destroy]

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :events, only: [:index, :show, :update, :destroy]
    resources :users, only: [:index, :show, :update, :destroy]
    resources :categories, only: [:index, :create, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
