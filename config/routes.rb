Rails.application.routes.draw do
  get 'pages/home'
  resources :reported_incidents do
    resources :comments
    collection do
      post :import
    end
  end
  
  get :automated_remediation, to: 'reported_incidents#auto_incident_reponse'
  get :resolved_by_analyst, to: 'reported_incidents#analyst'
  get :spam, to: "reported_incidents#spam"
  get :phishing, to: "reported_incidents#phishing"
  get :safe, to: "reported_incidents#safe"
  get :unclassified, to: "reported_incidents#unclassified"
  delete :clear_reported_incidents, to: "reported_incidents#clear"
  root 'pages#home'
end
