Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: 'pages#home'
  resources :users, param: :slug do
    resources :mirrors, only: [:update]
    get '/ongoing_projects', to: 'mirrors#ongoing_projects'
    get '/portfolio', to: 'mirrors#past_projects'
  end
  resources :projects, param: :slug do
    resources :collabs, only: [:new, :create]
    resources :jobs, only: [:new, :create]
    # member do
    #   post :apply
    #   post :unapply
    # end
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
  # resources :chatrooms, only: [:show, :create, :index]
  resources :messages, only: [:create]
  # resources :applies do
  #   member do
  #     patch :change_status
  #   end
  # end
  get '/dashboard', to: 'pages#dashboard'
  get '/collaboration', to: 'pages#collaboration'
  # ^^ still in use?

  get '/search', to: 'pages#general_search'
  get '/user_search', to: 'pages#user_search'
  get '/project_search', to: 'pages#project_search'

  get '/upcoming_projects_dash', to: 'pages#upcoming_projects_dash'
  get '/past_projects_dash', to: 'pages#past_projects_dash'

  get '/open_jobs_dash', to: 'pages#open_jobs_dash'
  get '/close_jobs_dash', to: 'pages#close_jobs_dash'

  get '/hold_received_dash', to: 'pages#hold_received_dash'
  get '/accepted_received_dash', to: 'pages#accepted_received_dash'
  get '/rejected_received_dash', to: 'pages#rejected_received_dash'

  get '/upcoming_collabs_dash', to: 'pages#upcoming_collabs_dash'
  get '/past_collabs_dash', to: 'pages#past_collabs_dash'

  get '/hold_sent_dash', to: 'pages#hold_sent_dash'
  get '/accepted_sent_dash', to: 'pages#accepted_sent_dash'
  get '/rejected_sent_dash', to: 'pages#rejected_sent_dash'

  get '/upcoming_projects', to: 'projects#upcoming_projects'

  # get '/user_upcoming_projects', to: 'users#upcoming_projects'
  # get '/user_past_projects', to: 'users#past_projects'
  # get '/user_upcoming_collabs', to: 'users#upcoming_collabs'
  # get '/user_past_collabs', to: 'users#past_collabs'


  # get '/portfolio_own_projects', to: 'users#portfolio_own_projects'
  # get '/portfolio_collabs', to: 'users#portfolio_collabs'

end
