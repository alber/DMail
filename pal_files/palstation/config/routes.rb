Rails.application.routes.draw do
  get 'stations/identity', to: 'stations#identity'


  resources :stations
  resources :messages
  resources :waypoints
  resources :flightplans
  resources :payloads
  resources :weathers
  resources :pals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
