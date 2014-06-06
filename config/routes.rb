TennisBook::Application.routes.draw do

  resources :tournaments


  resources :matches


  resources :players


  resources :friendships


  devise_for :users, :skip => [:sessions], :controllers => {:registrations => "registration"}
  as :user do
    get 'join' => 'registration#new', :as => :new_user_registration
    post 'join' => 'registration#create', :as => :user_registration
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users


  root :to => 'static_pages#home'

  # match '/getdata', :to =>  'users#get_usta_data'
  match '/search_opponent', :to =>  'users#search_opponent'
  match '/add_new_player', :to =>  'users#add_new_player', :as => "add_new_player"
  match '/choose_opponent', :to =>  'users#narrow_results', :as => "narrow_results"
  match '/switch_accounts', :to =>  'users#switch_accounts', :as => "switch_accounts"

  post '/send_friend_invite', :to => "players#send_friend_invite", :as => "send_friend_invite"
  get '/full_profile/:id', :to => "players#opponent_profile", :as => "opponent_profile"
  
  get '/my_tournaments', :to =>  'tournaments#my_tournaments', :as => "my_tournaments"
  get '/tournament/:id', :to =>  'tournaments#edit', :as => "tournament"
  
  match '/opponent_results/:id', :to =>  'users#opponent_results', :as => "opponent_result"
  get '/dash', :to =>  'users#dash', :as => "dash"
  get '/results', :to =>  'users#results', :as => "results"
  get '/results_by_date', :to =>  'users#results_by_date', :as => "results_by_date"
  
  get '/my_friends', :to =>  'users#my_friends', :as => "my_friends"
  get '/my_profile', :to =>  'users#profile', :as => "profile"
  get '/step_2', :to =>  'users#step2', :as => "step2"

  get '/loading', :to =>  'static_pages#loading', :as => "loading"
  get '/privacy', :to =>  'static_pages#privacy', :as => "privacy"

  match '/destroy_user', :to => "users#destroy_old", :as => "destroy_old", :via => :delete


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
