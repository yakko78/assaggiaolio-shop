Rails.application.routes.draw do

  get '/termini-e-condizioni', to: 'pages#termsconditions'
  get '/garanzia', to: 'pages#warranty'
  get '/metodi-di-pagamento', to: 'pages#paymentmethods'
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'settings/change_locale'

  resources :shipping_table_rates
  resources :shipping_addresses
  resources :billing_addresses
  resources :orders
  resources :products
  resources :line_items
  resources :carts
  get 'store/index'

  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  post "/orders/:id" => "orders#show"
  post "/hook" => "orders#hook"
  post "/hook_triveneto" => "orders#hook_triveneto"

  get  '/calculate_shipping/:id' => 'orders#calculate_shipping'
  get '/error' => 'orders#error'

  get "/thankyou", to: "orders#show"

  root 'store#index', as: 'store'

  get '/.well-known/acme-challenge/:id' => 'store#letsencrypt'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
