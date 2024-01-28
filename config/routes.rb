Rails.application.routes.draw do
  resources :reported_incidents do
    collection do
      post :import
    end
  end
  
  delete :clear_reported_incidents, to: "reported_incidents#clear"
  root 'pages#home'
end
