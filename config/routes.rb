NomadicsApp::Application.routes.draw do

  root to: 'sessions#index'


  resources :users do
    member do
      # REV: should be nested resources I think
      get "photo"
      get "friends"
    end

    collection do
      get "search"
    end
  end
  resource :sessions, :only => [:new, :create, :destroy]
  resources :relationships
  resources :requests

  resources :travels do
    # REV: likewise
    collection do
      get "search"
      get "results"
    end
  end
end
