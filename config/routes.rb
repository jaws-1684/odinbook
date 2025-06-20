Rails.application.routes.draw do
get "/search", to: "search#index"

resources :profiles, path: "/profile/", only: [:index, :show] do
  resources :friend_requests, path: "/friends/", module: :profiles
end
resources :friend_requests, only: [:create, :update, :destroy]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'}
    
  resources :posts, path: "/feed/" do
     resources :comments, module: :posts

     member do
       post "like", to: "posts#like"
       delete "unlike", to: "posts#unlike"
     end
   end

  resources :comments do
    resources :comments, module: :comments
  end


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
   root "posts#index"
   
end
