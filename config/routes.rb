NomadicsApp::Application.routes.draw do

  root to: 'sessions#index'


  resources :users do
    member do
      get "photo"
      get "friends"
    end

    collection do
      get "results"
    end
  end
  resource :sessions, :only => [:new, :create, :destroy]
  resources :relationships
  resources :requests

  resources :travels do
    collection do
      get "search"
      get "results"
    end
  end
end
