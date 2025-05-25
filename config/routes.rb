Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game
        resources :player
        resources :frame
          resources :pin
    end
  end
end
