Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy'
  end
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, :likes
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/users/:id', to: 'users#show'
  get '/users/:user_id/posts', to: 'posts#index'
  get '/users/:user_id/posts/new', to: 'posts#new'
  get '/users/:user_id/posts/:id', to: 'posts#show'
  post '/users/:user_id/posts/new', to: 'posts#create'

  # Defines the root path route ("/")
  # root "articles#index"
end
