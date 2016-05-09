Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'resources/sensors', to: 'basic_resources#index_sensors'
  get 'resources/actuators', to: 'basic_resources#index_actuators'
end
