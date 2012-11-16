SelfAssessment::Application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'questionnaires#index'

  resources :questionnaires, :only => [:index, :show, :update] do
    collection do
      get :reset
    end
  end
  
  resources :reckoner, :only => [:index]
  
  resources :calculator, :only => [:index]

  resources :settings, :only => [:show]

end
