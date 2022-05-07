Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :gurumes do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  patch 'gurumes/:id' => 'gurumes#update'
  delete 'gurumes/:id' => 'gurumes#destroy'
  get 'gurumes/:id/edit' => 'gurumes#edit', as:'edit_gurumes'
  root 'gurumes#top'
end
