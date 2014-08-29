Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'session#create'
  get '/sign_in', to: 'session#new'
  get '/sign_out', to: 'session#destroy'
  resources :client_applications
  get '/playground', to: 'playground#index'
  get '/terms', to: 'pages#show', id: 'terms'
  get '/docs', to: 'pages#show', id: 'docs'
  get '/docs/authentication', to: 'pages#show', id: 'authentication'
  get '/start', to: 'start#show'
  get '/help', to: 'help#show'
end
