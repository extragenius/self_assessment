SelfAssessment::Application.routes.draw do

  mount Ominous::Engine => "ominous"
  mount Disclaimer::Engine => "disclaimer"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'questionnaires#index'

  resources :questionnaires, :only => [:index, :show, :update] do
    collection do
      get :reset
    end
  end
  
  resources :answer_stores, :only => [:show, :update]
  
  resources :reckoner, :only => [:index]
  
  resources :calculator, :only => [:index]

  resources :settings, :only => [:show]

  resources :rule_sets, :only => [:show]
  
  resources :reports, :only => [:show, :index]
  
  resources :answers, :only => [:index]
  
  resources :guides, :only => [:index, :show]

  namespace :admin do
    
    resources :guides do
      member do
        get :move_up
        get :move_down
      end
    end
  end

end
