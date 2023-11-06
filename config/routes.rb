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
    resources :rooms, except: [:destroy]
  end
end

