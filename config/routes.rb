Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]
  resource :profile, only: [:create, :show, :update, :destroy]
  resources :users, only: [:show, :index]
  resources :questions, only: [:show, :index, :create, :update]
end
