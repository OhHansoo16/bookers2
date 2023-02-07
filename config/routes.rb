Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :books, only[home, index, create, show, edit, update, destroy]  
  resources :users, only: [:show, :edit, :update]
end
