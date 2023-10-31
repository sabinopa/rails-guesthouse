Rails.application.routes.draw do
  devise_for :guest, controllers: { 
    sessions: 'guest/sessions', 
    registrations: 'guest/registrations'
  }
  devise_for :host, controllers: { 
    sessions: 'host/sessions',
    registrations: 'host/registrations' 
  }
  
  root to: 'home#index'
end
