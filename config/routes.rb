Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'
  resources :users, param: :slug
  resources :projects, param: :slug do
    member do
      post :apply
      post :unapply
    end
  end
  get '/messages', to: 'pages#messages'
end
