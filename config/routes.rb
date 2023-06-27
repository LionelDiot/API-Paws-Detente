Rails.application.routes.draw do
  namespace :admin do
    resources :items
  end
  resources :items, except: [ :edit, :new, :destroy]
  devise_for :users,
            controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                passwords: 'users/passwords'
            },
            defaults: { format: :json }
  get '/member-data', to: 'members#show'
  post '/checkout', to: 'charges#create_checkout_session'
  get '/cart', to: 'carts#show'
  post '/cart', to: 'carts#add'
  patch '/cart', to: 'carts#edit'
  delete '/cart', to: 'carts#destroy'
  post '/stripe/webhook', to: 'charges#success'
  namespace :admin do
    get '/dashboard', to: 'items#dashboard'
    resources :articles
  end
  get '/favorites', to: 'members#index'
  post '/favorites', to: 'members#switch'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end