SelfAssessment::Application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  mount Ominous::Engine => "/ominous"
  
  mount Disclaimer::Engine => "/disclaimer"


  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => 'questionnaires#index'

  resources :questionnaires, :only => [:index, :show, :update] do
    collection do
      get :reset
    end
  end
  
  resources :answer_stores, :only => [:show, :new, :update, :create]
  
  resources :reckoner, :only => [:index]
  
  resources :calculator, :only => [:index]

  resources :settings, :only => [:show]

  resources :rule_sets, :only => [:show]
  
  resources :reports, :only => [:show, :index]

  namespace :admin do
    resources :questionnaires do
      resources :questions, :only => [:move_up, :move_down] do
        member do
          get :move_up
          get :move_down
        end
      end
    end

    resources :questions do
      resources :answers, :only => [:move_up, :move_down, :remove] do
        member do
          get :move_up
          get :move_down
          get :remove
        end
      end
    end
    
    resources :rule_sets do
      resources :answers, :only => [:add, :delete] do
        member do
          put :add
          put :delete
        end
      end
    end
  end

end
