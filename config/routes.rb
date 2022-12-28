Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  root to: 'pages#home'
  resources :users, param: :slug do
    resources :mirrors, only: [:update]
    get '/ongoing_projects', to: 'mirrors#ongoing_projects'
    get '/portfolio', to: 'mirrors#past_projects'
  end
  get '/confirmation_pending', to: 'users#after_registration_path'
  resources :projects, param: :slug do
    resources :collabs, only: [:new, :create]
    resources :jobs, only: [:new, :create]
  end
  resources :collabs, only: [:destroy]

  resources :jobs, only: [:show, :destroy, :edit, :update, :index] do
    resources :inquiries, only: [:new, :create]
  end
  resources :inquiries, only: [:show, :destroy, :edit, :update] do
    member do
      patch :change_status
    end
  end
  resources :chatrooms, only: [:show, :index]
  resources :messages, only: [:create]
  resources :events, param: :slug, only: [:show, :index] do
    member do
      post :attend
      post :unattend
    end
  end


  get '/dashboard', to: 'dashboards#dashboard'
  get '/upcoming_projects_dash', to: 'dashboards#upcoming_projects_dash'
  get '/past_projects_dash', to: 'dashboards#past_projects_dash'
  get '/open_jobs_dash', to: 'dashboards#open_jobs_dash'
  get '/close_jobs_dash', to: 'dashboards#close_jobs_dash'
  get '/hold_received_dash', to: 'dashboards#hold_received_dash'
  get '/accepted_received_dash', to: 'dashboards#accepted_received_dash'
  get '/rejected_received_dash', to: 'dashboards#rejected_received_dash'
  get '/upcoming_collabs_dash', to: 'dashboards#upcoming_collabs_dash'
  get '/past_collabs_dash', to: 'dashboards#past_collabs_dash'
  get '/hold_sent_dash', to: 'dashboards#hold_sent_dash'
  get '/accepted_sent_dash', to: 'dashboards#accepted_sent_dash'
  get '/rejected_sent_dash', to: 'dashboards#rejected_sent_dash'

  get '/upcoming_projects', to: 'projects#upcoming_projects'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
end
