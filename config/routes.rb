Rails.application.routes.draw do
  devise_for :users,
            controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                passwords: 'users/passwords'
            },
            defaults: { format: :json }
  get '/member-data', to: 'members#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end