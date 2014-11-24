Rails.application.routes.draw do


  root 'access#landing'
  
  get 'login', to: "access#login", as: 'login'

  get 'signup', to: "access#signup", as: 'signup'

  post 'login', to: "access#attempt_login"

  post 'signup', to: "access#create"

  # get 'home', to: "access#home", as: 'home'

  get 'logout', to: "access#logout"

  get '/forgot' => 'access#forgot_password'
  post '/send_reset' => 'access#send_reset'
  get '/reset/:token' => 'access#reset_password'
  post '/update_password' => 'access#update_password'


  resources :categories

  resources :photos do
    resources :orders, only: [:create, :new]
  end

  resources :users, except: [:create, :new] do
    resources :photos
    resources :orders, only: [:index]
    resources :banks, only: [:new, :create]
  end


  get 'home', to: "photos#all", as: 'all_photos'
end
