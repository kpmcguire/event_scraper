Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  root :to => 'events#featured_events'

  resources :users do
    member do
      get :delete
    end
  end

  resources :events do
    member do
      get :delete
    end

    collection do
      get 'day'
    end

    collection do
      get 'search'
    end

    collection do
      get 'featured_events'
    end    

    collection do
      delete 'remove_all'
    end
  end 
  
  resources :venues do
    member do
      get :delete
    end

    collection do
      get 'search'
    end

    collection do
      delete 'remove_all'
    end
  end   

  resources :organizations do
    member do
      get :delete
    end
  end
end
