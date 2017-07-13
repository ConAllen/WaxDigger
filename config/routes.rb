Rails.application.routes.draw do
  devise_for :users
#this tells rails it needs to include the listing id number in the url in the order page
  resources :records do
      resources :orders
    end

  get 'pages/about'
  get 'pages/contact'

#the below root is setting up the previous order sales url localhost:3000/sales
  get 'sales' => "orders#sales"
#the below root is setting up the order purchases url localhost:3000/purchases
  get 'purchases' => "orders#purchases"

# the below line of code is setting up a new URL localhost/seller. which is catorized by records
  get 'seller' => "records#seller"

# The below root link has changed my index page to the record listing page.
  root 'records#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
