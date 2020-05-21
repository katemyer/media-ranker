Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Works
  get    "/works"          , to: "works#index",   as: :works
  post   "/works"          , to: "works#create"
  get    "/works/new"      , to: "works#new",     as: :new_work
  get    "/works/:id"      , to: "works#show",    as: :work
  patch  "/works/:id"      , to: "works#update"
  put    "/works/:id"      , to: "works#update"
  delete "/works/:id"      , to: "works#destroy"
  get    "/works/:id/edit" , to: "works#edit",    as: :edit_work


  #Users
  get    "/users"          , to: "users#index",   as: :users
  post   "/users"          , to: "users#create"
  get    "/users/new"      , to: "users#new",     as: :new_user
  get    "/users/:id"      , to: "users#show",    as: :user
  patch  "/users/:id"      , to: "users#update"
  put    "/users/:id"      , to: "users#update"
  delete "/users/:id"      , to: "users#destroy"
  get    "/users/:id/edit" , to: "users#edit",    as: :edit_user

  #Votes
  get    "/votes"          , to: "votes#index",   as: :votes
  post   "/votes"          , to: "votes#create"
  get    "/votes/new"      , to: "votes#new",     as: :new_vote
  get    "/votes/:id"      , to: "votes#show",    as: :vote
  patch  "/votes/:id"      , to: "votes#update"
  put    "/votes/:id"      , to: "votes#update"
  delete "/votes/:id"      , to: "votes#destroy"
  get    "/votes/:id/edit" , to: "votes#edit",    as: :edit_vote



  root 'homepages#index'
end
