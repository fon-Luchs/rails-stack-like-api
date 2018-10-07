Rails.application.routes.draw do
  resource :profile, only: [:create, :destroy, :show, :update]
  resource :session, only: [:create, :destroy]
  resources :users,  only: [:show, :index]
  resources :questions, only: [:show, :create, :update, :index] do
    resource :rate, only: :create
    resource :answers, only: [:create, :show]
  end

  post 'answers/:answers_id/rate', to: 'rates#create'
end
