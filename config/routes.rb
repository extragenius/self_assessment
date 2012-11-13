SelfAssessment::Application.routes.draw do
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'questionnaires#index'

  resources :questionnaires, :only => [:index, :show, :update] do
    collection do
      get :reset
    end
  end
  
  resources :reckoner
  
  resources :calculator

end
