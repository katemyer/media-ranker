Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Works
  get '/works', to: 'works#index'
  get '/works/:id', to: 'works#show'
  

  #Users
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'

  root 'homepages#index'
end
