require 'sidekiq/web'

Rails.application.routes.draw do
  get 'shopping_carts/index'
  mount Sidekiq::Web => '/jobmonitor'

  devise_for :users, as: "web"


  get  '/users/:id/profile', to: 'users#profile', as: "my_profile"
  get  '/users/:id/edit_profile', to: 'users#edit_profile', as: "edit_profile"
  get  '/users/set_current_locale', to: 'users#set_current_locale', as: "set_current_locale"

  root to: "categories#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions',
    passwords: 'api/v1/passwords',
    token_validations: 'api/v1/token_validations'
  }, skip: %i[omniauth_callbacks registrations]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/default_locales', to: 'api#default_locales'

      resource :user, only: %i[show update]

      devise_scope :user do
        resources :users, only: [] do
          controller :registrations do
            post :create, on: :collection
          end
        end
      end

      resource :ad do
        get '/fetch_ads', to: 'ads#ads'
      end

      resource :service do
        get '/fetch_services', to: 'services#fetch_services'
        get '/show_service', to: 'services#show_service'
      end


    end
  end
end
