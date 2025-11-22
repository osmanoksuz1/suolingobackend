Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:create, :show]
      resources :voice_samples, only: [:create]
      resources :lessons, only: [:create]
      resources :videos, only: [] do
        collection do
          post :generate
        end
        member do
          get :status
        end
      end
    end
  end
end
