Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'session#create'
  get '/sign_in', to: 'session#new'
  get '/sign_out', to: 'session#destroy'
  resources :client_applications
  get '/playground', to: 'api_swagger#index'
  get '/terms', to: 'pages#show', id: 'terms'
  get '/start', to: 'start#show'
  get '/help', to: 'help#show'
end
