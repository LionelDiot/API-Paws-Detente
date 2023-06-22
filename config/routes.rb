Rails.application.routes.draw do
  resources :items
  devise_for :users,
            controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                passwords: 'users/passwords'
            },
            defaults: { format: :json }
  get '/member-data', to: 'members#show'
  post '/checkout', to: 'charges#create_checkout_session'
  get 'carts/show'
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"

  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end