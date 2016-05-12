Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'resources', to: 'basic_resources#index'
  get 'resources/sensors', to: 'basic_resources#index_sensors'
  get 'resources/actuators', to: 'basic_resources#index_actuators'
  get 'resources/:id', to: 'basic_resources#show', as: :basic_resource

end
