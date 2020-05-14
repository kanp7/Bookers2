Rails.application.routes.draw do
  get 'home/top'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  resources :users, only: [:show, :index, :edit, :update]

  resources :books
  get 'home/about' => 'home#about'
  get '/' => 'home#top'
  
end
