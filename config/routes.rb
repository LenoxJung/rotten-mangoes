RottenMangoes::Application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  resources :users
  resource :session, only: [:new, :create, :destroy]
  root to: 'movies#index'

  namespace :admin do
    resources :users do
      get :switch, :switchback
    end
  end

end
