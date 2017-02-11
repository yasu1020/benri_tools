Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #resources :scraping

  get '/scraping', to: 'scraping#index'
  get '/scraping/show', to: 'scraping#show'

  get '/google', to: 'google#index'
  get '/google/show', to: 'google#show'

end
