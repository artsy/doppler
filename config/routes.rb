Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/:provider/callback', to: 'session#create'
  get '/sign_in', to: 'session#new'
  get '/sign_out', to: 'session#destroy'

  resources :client_applications

  get '/docs', to: 'pages#show', id: 'docs'

  # Partner API

  get '/v1', to: 'pages#show', id: 'v1/index'
  get '/v1/playground', to: 'playground#index'
  get '/v1/terms', to: 'pages#show', id: 'v1/terms'

  # Public API

  get '/v2', to: 'pages#show', id: 'v2/index'
  %i[
    applications
    artists
    artworks
    authentication
    bidder_positions
    bidders
    bids
    collection_items
    collections
    docs
    editions
    errors
    fairs
    genes
    http
    images
    links
    markdown
    pagination
    partners
    profiles
    rate_limiting
    sales
    search
    shows
    status
    user_details
    users
  ].each do |page|
    get "/v2/docs/#{page}", to: 'pages#show', id: "v2/docs/#{page}"
  end
  get '/v2/start', to: 'v2/start#show'
  get '/v2/playground', to: 'playground#index'
  get '/v2/terms', to: 'pages#show', id: 'v2/terms'

  get '/help', to: 'help#show'
end
