Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'
  get '/chat_page/:id' => 'chat#chat_page', :as => :chat_page
  get '/current_user_id', to: 'application#current_user_id'
  resources :chat, only: [:index] do
    post 'message', on: :collection, to: 'chat#create_message'
  end
  mount ActionCable.server => '/cable'
end
