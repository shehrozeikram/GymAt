require 'sidekiq/web'

Rails.application.routes.draw do
  get 'shopping_carts/index'
  mount Sidekiq::Web => '/jobmonitor'

  devise_for :users, as: "web"


  get  '/users/:id/profile', to: 'users#profile', as: "my_profile"
  get  '/users/:id/edit_profile', to: 'users#edit_profile', as: "edit_profile"
  get  '/users/set_current_locale', to: 'users#set_current_locale', as: "set_current_locale"


  resource :service do
    get '/index', to: "services#index"
    get '/shop', to: "services#shop"
    get '/facilities', to: "services#facilities"
    get '/individual', to: "services#individual"
    get '/appartments', to: "services#appartments"
    get '/get_time_slots', to: "services#get_time_slots"
    post '/book_appointment', to: "services#book_appointment"
  end

  root to: "services#index"



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
      devise_for :users, :controllers => {
        registrations: 'registrations'
      }


      resource :reviews do
        post '/create_review', to: 'reviews#create_review'
        get '/show_reviews', to: 'reviews#show_reviews'
      end

      resource :shops do
        get '/show_shop', to: 'shops#show_shop'
        get '/fetch_shops', to: 'shops#fetch_shops'
        post '/checkout', to: 'shops#checkout'
        get '/fetch_related_products', to: 'shops#fetch_related_products'

      end


      resource :trainers do
        get '/show_trainer', to: 'trainers#show_trainer'
        get '/fetch_trainers', to: 'trainers#fetch_trainers'
        post '/create_trainer_subscription', to: 'trainers#create_trainer_subscription'
      end

      resource :training_programs do
        get '/show_training_program', to: 'training_programs#show_training_program'
        get '/fetch_training_programs', to: 'training_programs#fetch_training_programs'
        # post '/create_trainer_subscription', to: 'trainers#create_trainer_subscription'

        get '/show_activity', to: 'training_programs#show_activity'
        get '/fetch_activities', to: 'training_programs#fetch_activities'

      end



      resource :payments do
        post '/payment', to: 'payments#payment'

      end

      resource :resturants do
        get '/show_resturant', to: 'resturants#show_resturant'
        get '/fetch_resturants', to: 'resturants#fetch_resturants'

      end

      resource :resturants_dishes do
        get '/show_dish', to: 'resturants_dishes#show_dish'
        get '/fetch_dishes', to: 'resturants_dishes#fetch_dishes'
        get '/best_seller', to: 'resturants_dishes#best_seller'
      end

      resource :business do
        get '/show_business', to: 'businesses#show_business'
        get '/fetch_business', to: 'businesses#fetch_business'

        # subscription route
        post '/create_subscription', to: 'businesses#create_subscription'
      end

      resource :dish_orders do
        post '/create_order', to: 'dish_orders#create_order'
        get '/order_again', to: 'dish_orders#order_again'
      end


    end
  end
end
