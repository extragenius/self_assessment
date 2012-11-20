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
  
  namespace :admin do
    resources :questionnaires do
      resources :questions, :only => [:move_up, :move_down] do
        member do
          get :move_up
          get :move_down
        end
      end
    end
  end

end
