TwitterDiversity::Application.routes.draw do
  
  # sessions params:
  # searched_for -> when you click search button on home, who you want to see pre: filling in your info
  # ask_info -> false if they said no/have already filled out, otherwise nil
  # screen_name -> grab from oauth, has to match route if they want to edit/delete
  
  ########### PUBLIC ############################
  
  get "/" => 'public#home' #if they click search, sends that name to post:results
  get "/test/foundation" => 'test#test'
  
  ########## USERS ##############################
  

  # get "/users/new" => 'users#new'
  #
  # post "/users" =>'users#create'
  
  post "/logout" => 'users#logout', as: :logout
  
  get "/users/:screen_name/edit" => 'users#edit' #protected
  
  put "/users/:id" => 'users#save', as: :user
  
  delete "/users/:id" => 'users#delete' #protected
   
  get "/users/:id" => 'users#view' #protected
  
  ########## RESULTS ###########################
  
  get "/current" => 'results#current'
  
  get "/current/:screen_name" => 'results#current' #redirects to /:id
  
  get "/results/:id" => 'results#view' #pulls from results table
  
  post "/results" => 'results#create' #generates results record to populate /:id, make sure to clear session after this loads
  
  get "/reroute" => 'results#reroute' #TODO would like to change to a post route
  
  ######### OMNIAUTH ###########################
  
  get "/auth/twitter/callback" => "public#return"

  get "/auth/failure" => "public#failure"
  
  ######### BAD USER ENTRY REROUTING ###########
  
  get "/:screen_name" => 'results#current'
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
