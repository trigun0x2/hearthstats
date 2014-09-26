Hearthstats::Application.routes.draw do

  # Gem routes
  #
  get '/s/:id' => "shortener/shortened_urls#show"

  # Delayed_job_web
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  get "cards/index"
  get "streams/index"

  resources :teams

  # match '(*foo)' => 'additional#serverupgrade'
  resources :tournies do
    collection do
      post 'signup'
      get 'past'
      post 'regtourny'
      post 'createtourny'
      get 'calendar'
    end
  end

  resources :blind_drafts do
    member do
      put "reveal_card"
      put "pick_card"
      put "new_card"
      get "draft"
      post "end_draft"
      post "create_deck"
    end
  end

  # Notifications

  post "notifications/note_read"

  # get "profile/edit"

  get "/contactus", to: "additional#contactus"
  get "/aboutus", to: "additional#aboutus"
  get "/help", to: "additional#help"
  get "/changelog", to: "additional#changelog"
  get "/privacy", to: "additional#privacy"
  get "/news", to: "additional#news"
  get "/openings", to: "additional#openings"
  get "/contest", to: "additional#contest_video"
  get "/league", to: "additional#league"

  #apps
  get "/uploader", to: "additional#uploader"
  get "/uploader/download/win", to: "additional#uploader_download_win"
  get "/uploader/download/osx", to: "additional#uploader_download_osx"

  # Monthly Reports
  get '/jan', to: redirect('/reports/jan/index.html')
  get "/dec", to: "welcome#decreport"
  get "/nov", to: "welcome#novreport"
  get "/mar", to: redirect('/reports/mar/index.html')
  get "/apr", to: "welcome#april_report"
  get "/may", to: "welcome#may_report"
  get "/june", to: "welcome#june_report"
  get "/july", to: "welcome#july_report"
  get "/aug", to: "welcome#aug_report"
  get "/gen_report", to: "welcome#generate_report"
  get "welcome/ranked_test"
  get "welcome/select_klass"

  # Admin Stats Export

  get "admin/export_arena"
  get "admin/export_con"
  get "admin/ann", to: "admin#ann"
  post "admin/anncreate"

  get "welcome/index"
  get "welcome/demo_user"
  post "welcome/newsletter_sub"

  resources :arena_runs do
    collection do
      get 'end'
      post 'endrun'
    end
  end

  resources :profiles do
    get 'sig'
    post 'set_locale', on: :collection
  end

  resources :decks do
    collection do
      get 'active_decks'
      get 'public'
      get 'new_splash'
      post 'submit_active_decks'
      get 'copy'
      get 'tags'
    end

    member do
      post 'version'
      post 'delete_active'
      get 'public_show'
      get 'copy'
    end
  end

  resources :dashboards do
    collection do
      get 'race'
      get 'fullstats'
    end
  end

  # devise_for :users
  devise_for :users, controllers: {registrations: "registrations"}
  resources :constructeds do
    collection do
      get :stats
      post :quick_create
      get :win_rates
    end
  end

  resources :cards do
    collection do
    end
  end

  resources :tournaments do
    post :submit_deck, on: :member
    post :join, on: :member
    post :quit, on: :member
    post :admin, on: :member
    post :start, on: :member
  end

  resources :tourn_matches do
  end

  resources :arenas do
    collection do
      get :archives
      get :stats
      post :quickentry
      get :matches
    end
  end
  authenticated :user do
    get '/', to: 'dashboards#index'
  end

  devise_scope :user do
    root to: "welcome#index"
  end

  resources :matches do
    delete :delete_all, on: :collection
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  # HearthStats API
  namespace :api do
    namespace :v1 do
      resources :cards
      get "arenas/show"
      post "arenas/new"

      get "constructeds/show"
      post "constructeds/new"

      get "arena_runs/show"
      post "arena_runs/new"
      get "arena_runs/end"

      post "matches/new"

      get "decks/show"
      get "decks/find"
      post "decks/delete"
      post "decks/activate"
      post "decks/slots"
      get "users/premium"
      post "decks/create"
    end

    namespace :v2 do
      devise_for :users
      get "arenas/show"
      post "arenas/new"

      get "constructeds/show"
      post "constructeds/new"

      get "arena_runs/show"
      post "arena_runs/new"
      get "arena_runs/end"

      post "matches/new"
      get "matches/query"

      get "decks/show"
      get "decks/find"
      post "decks/activate"
      post "decks/slots"
    end
  end
end
