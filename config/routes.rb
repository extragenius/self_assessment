SelfAssessment::Application.routes.draw do
  
  root :to => 'answers#tabs'

  resources :questions do 
    member do
      get :delete
    end
  end
  
  resources :questionnaires do 
    member do
      get :delete
      post :answer
      get :tab
    end
    
    collection do
      get :tabs
      get :reset
    end
  end
  
  resources :rule_sets do
    member do
      get :delete
    end
  end
  
  resources :answers, :only => [:index, :show] do
    collection do
      get :tabs
    end
  end
  
  resources :reckoner
  
  resources :calculator

end
