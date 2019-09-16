Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :csv_uploads do
    collection do
      get :delete_all
    end
  end
end
