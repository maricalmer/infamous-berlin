Rails.application.config.after_initialize do
  RailsAdmin.config do |config|
    config.asset_source = :webpacker
  
    ### Popular gems integration
  
    ## == Devise ==
    config.authenticate_with do
      warden.authenticate! scope: :user
    end
    config.current_user_method(&:current_user)
  
    config.authorize_with do
      unless current_user.admin?
        flash[:alert] = 'Heute leider nicht...'
        redirect_to main_app.root_path
      end
    end
  
    config.included_models = ["User", "Project", "Job", "Inquiry", "Event"]
  
    config.model 'User' do
      edit do
        include_fields :email, :password, :bio, :skills, :username, :title, :website,
                      :facebook, :instagram, :soundcloud, :youtube, :mixcloud,
                      :linkedin, :twitter
      end
    end
  
    config.model 'Project' do
      edit do
        include_fields :title, :description, :location, :category, :date, :status
      end
    end
  
    config.model 'Job' do
      edit do
        include_fields :title, :location, :money, :skills_needed, :description,
                      :payment, :status
      end
    end
  
    config.model 'Inquiry' do
      edit do
        include_fields :experience, :motivation, :status
      end
    end
  
    config.model 'Event' do
      create do
        include_fields :title, :venue, :address, :organizer, :organizer_type, :date,
                      :genre, :recommended, :description, :media, :photo
      end
      edit do
        include_fields :title, :venue, :address, :organizer, :organizer_type, :date,
                      :genre, :recommended, :description, :media, :photo
      end
    end

    ## == CancanCan ==
    # config.authorize_with :cancancan

    ## == Pundit ==
    # config.authorize_with :pundit

    ## == PaperTrail ==
    # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

    ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

    ## == Gravatar integration ==
    ## To disable Gravatar integration in Navigation Bar set to false
    # config.show_gravatar = true
  end
end
