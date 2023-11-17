Rails.application.routes.draw do
  resources :geolocation do
    collection do
      get :retrieve
      post :add
      delete :delete
    end
  end
end
