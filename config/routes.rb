Rails.application.routes.draw do
  get '/health_check', to: 'home#health_check'
end
