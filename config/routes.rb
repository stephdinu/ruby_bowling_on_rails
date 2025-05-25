Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :player
      resources :pin
    end
  end
end
