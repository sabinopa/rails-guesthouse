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
  get 'host_reviews', to: 'reviews#host_reviews'
  
  root to: 'home#index'

  resources :searches
  resources :guesthouses, except: [:destroy] do
    post 'active', on: :member
    post 'inactive', on: :member
    get 'cities', on: :collection
    get 'search', on: :collection
    get 'guesthouse_reviews', on: :member
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
        resources :reviews, only: [:new, :create], shallow: true do
          get 'answer', on: :member
          post 'create_answer', on: :member
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :guesthouses, only: [:show, :index] do
        resources :rooms, only: [:index, :show] do
          get 'availability', on: :member
        end
      end
    end
  end
end