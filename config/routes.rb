Rails.application.routes.draw do
  devise_for :users
  resources :records
  get 'pages/about'
  get 'pages/contact'

# the below line of code is setting up a new URL localhost/seller. which is catorized by records
  get 'seller' => "records#seller"

# The below root link has changed my index page to the record listing page.
  root 'records#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
