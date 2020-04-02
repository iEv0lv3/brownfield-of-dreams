Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  root 'welcome#index'

  get 'tags/:tag', to: 'welcome#index', as: :tag

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create edit update destroy new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update destroy]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  get '/register', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/users/activate', to: 'users/emails#show'
  post '/friendships', to: 'friendships#create'
  get '/dashboard', to: 'users#show'

  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/auth/:provider/callback', to: 'sessions#update'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: %i[create update edit]

  resources :tutorials, only: %i[show index] do
    resources :videos, only: %i[show index]
  end

  resources :user_videos, only: %i[create destroy]
end
