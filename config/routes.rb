Rails.application.routes.draw do

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root to: 'searches#new'
  resources :searches

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :searches, only: [ :index ]
      resources :jobs, only: [ :index ]
    end
  end
end
