Rails.application.routes.draw do
  # API routes - no need for scoping if everything is an API
  resources :galleries
  resources :artworks

  # Batch upload endpoint
  post '/batch_uploads', to: 'batch_uploads#create'
end