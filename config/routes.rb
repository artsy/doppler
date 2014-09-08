Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'session#create'
  get '/sign_in', to: 'session#new'
  get '/sign_out', to: 'session#destroy'
  resources :client_applications
  get '/playground', to: 'playground#index'
  get '/terms', to: 'pages#show', id: 'terms'
  get '/docs', to: 'pages#show', id: 'docs'
  [
    :authentication,
    :pagination,
    :links,
    :http,
    :errors,
    :applications,
    :artists,
    :artworks,
    :edition_sets,
    :docs,
    :profiles,
    :partners,
    :status,
    :users,
    :user_details
  ].each do |page|
    get "/docs/#{page}", to: 'pages#show', id: "docs/#{page}"
  end
  get '/start', to: 'start#show'
  get '/help', to: 'help#show'
end
