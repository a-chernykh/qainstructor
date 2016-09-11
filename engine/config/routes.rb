require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v1 do
      resources :jobs, only: %i(create show), param: :token do
        collection do
          post :step
        end

        resources :job_assets, only: %i(index), path: 'assets'
      end
      resources :purchases, only: %i(create)
    end
  end

  resources :courses, only: [:index, :show] do
    member do
      get :continue
      get :toc
      get :purchased
    end
    resources :chapters, only: [:show] do
      member do
        post :finish
      end
    end
    resources :cheatsheets, only: [:show], param: :code
  end

  resources :redemptions, only: [:new, :create]

  # Discourse Single Sign On
  get '/discourse/sso' => 'discourse#sso'

  get '/pages/terms', as: :terms_page
  get '/pages/privacy', as: :privacy_page
  get '/pages/:page' => 'pages#show'

  root 'courses#index'
end
