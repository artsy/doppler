Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'session#create'
  get '/sign_in', to: 'session#new'
  get '/sign_out', to: 'session#destroy'
  resources :client_applications
  get '/playground', to: 'playground#index'
  get '/terms', to: 'pages#show', id: 'terms'
  get '/docs', to: 'pages#show', id: 'docs'
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
    get "/docs/#{page}", to: 'pages#show', id: "docs/#{page}"
  end
  get '/start', to: 'start#show'
  get '/help', to: 'help#show'
end
