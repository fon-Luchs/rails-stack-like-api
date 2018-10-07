Rails.application.routes.draw do
  resource :profile, only: [:create, :destroy, :show, :update]
  resource :session, only: [:create, :destroy]
  resources :users,  only: [:show, :index]
  resources :questions, only: [:show, :create, :update, :index] do
    resource :answers, only: [:create, :show]
  end
end
