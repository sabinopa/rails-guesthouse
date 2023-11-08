Rails.application.routes.draw do
  devise_for :guests, controllers: { 
    sessions: 'guests/sessions', 
    registrations: 'guests/registrations'
  }
  devise_for :hosts, controllers: { 
    sessions: 'hosts/sessions',
    registrations: 'hosts/registrations' 
  }
  
  root to: 'home#index'
  resources :guesthouses, except: [:destroy] do
    post 'active', on: :member
    post 'inactive', on: :member
    get 'cities', on: :collection
    resources :rooms, except: [:destroy] do
      post 'active', on: :member
      post 'inactive', on: :member
      resources :custom_prices, except: [:destroy]
    end
  end
end