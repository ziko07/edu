Rails.application.routes.draw do
  devise_for :users, controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations',
                       passwords: 'users/passwords',
                       confirmations: 'users/confirmations'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get '/admin' => redirect('/admin/dashboard')
  scope 'admin' do
    get '/dashboard' => 'admin#dashboard', as: :admin_dashboard
    get '/instructors' => 'admin#instructors', as: :admin_instructors
    get '/settings' => 'admin#settings', as: :admin_settings
    get '/courses' => 'admin#courses', as: :admin_courses
    get '/instructors/new' => 'admin#new_instructor', as: :admin_new_instructors
    post '/instructors/create' => 'admin#create_instructor', as: :admin_create_instructors
    patch '/instructors/:id/update' => 'admin#update_instructor', as: :admin_update_instructors
    patch '/update' => 'admin#update', as: :admin_update
    get '/instructors/:id' => 'admin#edit_instructor', as: :admin_edit_instructors
    get '/instructor/:user_id/reset_password' => 'admin#reset_password', as: :admin_instructor_reset_password
    get '/instructor/:user_id/unpublish' => 'admin#unpublish_instructor', as: :admin_instructor_unpublish
    put '/course/:id' => 'admin#update_course', as: :update_course_status
    resources :pages, only: [:index, :edit, :update]
  end


  get 'category_view' => 'welcome#category_view'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :courses, except: [:show]

  get '/course/:category', to: "courses#category_courses", as: :category_courses

  resources :instructors, only: [:new, :create] do
    collection do
      get :dashboard
      get '/:id', to: :profile, as: :profile
      get '/course/:id/submit_for_review', to: :review_submit, as: :review_submit
    end
  end

  get :page, to: 'welcome#edit_page'

  get '/:id', to: 'courses#show', as: :show_course

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
