Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :players, only: [:create, :show] do
        resources :games, only: [:create]
      end
      resources :games, only: [:show] do
        resources :frames, only: [:show] do
          post 'roll', on: :member
        end
      end
    end
  end
end
