Rails.application.routes.draw do
  get '/' => 'top#index'
  get 'recipes/index' => 'recipes#index'
  post 'report/create' => 'reports#create'
end
