Rails.application.routes.draw do
  resources :events
  resources :venues
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  resources :users, :except => [:show] do
    member do
      get :delete
    end
  end

  resources :organizations do
    member do
      get :delete
    end
  end

end
