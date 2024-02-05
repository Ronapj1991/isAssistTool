Rails.application.routes.draw do
  resources :reported_incidents do
    resources :comments
    collection do
      post :import
    end
  end
  
  get :spam, to: "reported_incidents#spam"
  get :phishing, to: "reported_incidents#phishing"
  get :safe, to: "reported_incidents#safe"
  get :unclassified, to: "reported_incidents#unclassified"
  delete :clear_reported_incidents, to: "reported_incidents#clear"
  root 'reported_incidents#index'
end
