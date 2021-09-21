Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'
  resources :users, param: :slug
  resources :projects, param: :slug do
    # member do
    #   post :apply
    #   post :unapply
    # end
  end
  resources :jobs
  resources :inquiries, only: [:create, :update, :destroy]
  resources :chatrooms, only: [:show, :index]
  # resources :chatrooms, only: [:show, :create, :index]
  resources :messages, only: [:create]
  # resources :applies do
  #   member do
  #     patch :change_status
  #   end
  # end
  get '/dashboard', to: 'pages#dashboard'
  get '/collaboration', to: 'pages#collaboration'
end
