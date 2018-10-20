Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]
  resource :profile, only: [:create, :show, :update, :destroy]
  resources :users, only: [:show, :index]
  resources :questions, only: [:show, :index, :create, :update] do
    resource :rate, only: :create
    resources :answers, only: [:create, :index]
  end

  post 'answers/:answer_id/rate', to: 'rates#create'
end
