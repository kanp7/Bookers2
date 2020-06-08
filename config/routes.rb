Rails.application.routes.draw do
  get 'chats/show'
  get 'search/search'
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  root 'home#top'
  get 'home/about' => 'home#about'
  resources :users, only: [:show, :index, :edit, :update] do
  	member do
  	 get :following, :followers
  	end
  end
  resources :chats, only: [:create, :show]

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only:[:create, :destroy]
  get 'search' => 'search#search'
end
