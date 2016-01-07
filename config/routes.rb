Rails.application.routes.draw do
  # get 'password_resets/new'

  # get 'password_resets/edit'

  # get 'sessions/new'

  # get 'users/new'

  root               'static_pages#home'
  get 'help'       =>'static_pages#help'
  get 'about'      =>'static_pages#about' 
  get 'contact'    =>'static_pages#contact'
  get 'signup'     =>'users#new'
  get 'login'      =>'sessions#new'
  post 'login'     =>'sessions#create'
  delete 'logout'  =>'sessions#destroy'

  # 用户
  resources :users do 
    member do
      get :following, :followers
      get :settings 
     post :update_settings
    end
  end


  namespace :settings do
    resource :account, only: [:show, :update]
    resource :basic, only: [:show, :update]
    resource :love, only: [:show, :update]
    resource :background, only: [:show, :update]
  end

  resources :account_activations, only: [:edit] # 账号激活
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only:[:create, :destroy]
  resources :relationships, only:[:create, :destroy]
end
