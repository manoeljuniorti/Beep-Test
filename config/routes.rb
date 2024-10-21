Rails.application.routes.draw do
  root 'application#index'

  namespace :api do
    namespace :v1 do
      get '/stories', to: 'stories#index'
      get '/stories/search', to: 'stories#search_hacker_news'
    end
  end
end