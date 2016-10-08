Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      :sessions      => "users/sessions",
      :registrations => "users/registrations",
      :passwords     => "users/passwords"
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#index'
  resources :plans
  resources :todos
  resources :time_slot_todos
end
