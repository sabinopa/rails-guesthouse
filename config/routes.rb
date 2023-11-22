Rails.application.routes.draw do
  devise_for :guests, controllers: { 
    sessions: 'guests/sessions', 
    registrations: 'guests/registrations'
  }
  devise_for :hosts, controllers: { 
    sessions: 'hosts/sessions',
    registrations: 'hosts/registrations' 
  }
  
  get 'my_bookings', to: 'bookings#my_bookings'
  get 'guesthouse_bookings', to: 'bookings#guesthouse_bookings'
  get 'ongoing_bookings', to: 'bookings#ongoing_bookings'
  root to: 'home#index'

  resources :searches
  resources :guesthouses, except: [:destroy] do
    post 'active', on: :member
    post 'inactive', on: :member
    get 'cities', on: :collection
    get 'search', on: :collection
    
    resources :rooms, except: [:destroy] do
      post 'active', on: :member
      post 'inactive', on: :member
      get 'availability', on: :member
      resources :custom_prices, except: [:destroy]
      resources :bookings, except: [:destroy] do
        get 'host_control', on: :member
        get 'checkout_register', on: :member
        patch 'checkin', on: :member
        patch 'checkout', on: :member
        patch 'host_canceled', on: :member
        patch 'guest_canceled', on: :member
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :guesthouses, only: [:show]
    end
  end
end