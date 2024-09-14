Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admin_users, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }
  
  namespace :admin do
    resources :vendors
    root to: 'dash_board#index'
    resources :orders, only: [:index, :show, :update] do
      member do
        get :confirm_order
        patch :update_confirmed_order
      end
      collection do
      end
    end
    resources :products
    resources :categories  
    resources :users 
  end
  # normal_user_routes

  devise_for :users 
  resources :users, only: [:show, :edit, :update] do 
    member do
      get :edit_password
    end
    collection do
      patch :update_password
    end
  end
  root "home#index"
  resources :market_places, only: :index
  resources :home do
    collection do
      get :privacy_policy
      get :terms_conditions
      get :shipping_policy
      get :return_policy
      get :cancellation_policy
      get :contacts
    end
  end
  resources :replies
  resources :questions
  resources :reviews
  resources :addresses do
    collection do
      get :new_order_address
      post :create_order_address
      get :postal_code_details
    end
  end
  resources :payments do
    member do
      post :payment_success
      get :get_payment_status
    end
    collection do
      post :webhook
    end
  end
  resources :cart_items
  resources :carts do 
    member do
      get :checkout, as: :checkout_process
    end
  end
  resources :order_items
  resources :orders do 
    member do
      get :invoice
      patch :cancel
    end
  end
  resources :products do
    collection do
      get :search
    end
  end
  resources :reviews
  resources :contacts, only: [:new, :create]
end
