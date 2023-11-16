Rails.application.routes.draw do
  get 'derivation/index'
  root "galleries#index"
  
  # mount ImageUploader.derivation_endpoint => "derivations/image"

  get 'image/show/:visibility/:model/:image/:id/:variant', to: "image#show", as: "image_derivation"

  get 'derivation/index'
  get "/derivations/image/*rest" => "derivations#image"


  resources :galleries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
