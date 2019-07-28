Rails.application.routes.draw do
  get 'stations/identity', to: 'stations#identity'
  get 'messages/outgoing', to: 'messages#outgoing'
  get 'messages/outbound/:id', to: 'messages#outbound'
  get 'messages/outbound_confirmed/:id', to: 'messages#outbound_confirmed'
  get 'messages/outbound_unconfirmed/:id', to: 'messages#outbound_unconfirmed'


  resources :stations
  resources :messages
  resources :waypoints
  resources :flightplans
  resources :payloads
  resources :weathers
  resources :pals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
