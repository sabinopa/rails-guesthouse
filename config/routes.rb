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
  
  authenticate :host do
    resources :guesthouses, except: [:destroy]
    resources :rooms, except: [:destroy]
  end
end

#get 'my_guesthouse', to: 'gesthouses#my_guesthouse'