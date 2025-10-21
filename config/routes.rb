Rails.application.routes.draw do
  get "errors/not_found"
  get "errors/internal_server_error"
  get "admin/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  scope "(:locale)", locale: /en|zh/ do
    resources :tasks
    namespace :admin do
      resources :users
    end

    root "sessions#new"

    get "signup", to: "user_registrations#new"
    post "signup", to: "user_registrations#create"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    get "/404", to: "errors#not_found", via: :all
    get "/500", to: "errors#internal_server_error", via: :all
  end
end
