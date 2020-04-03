Rails.application.routes.draw do
  devise_for :users
  devise_for :installs
  resources :users,only: [:index,:edit,:update,:show]
  resources :books
  root 'home#top'
  get 'home/about' => "home#about"
  get "users/[:id]/show" => "users#show"
end