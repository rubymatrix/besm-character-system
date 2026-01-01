Rails.application.routes.draw do
  namespace :rui do
    get "home", to: "pages#home"
    get "pricing", to: "pages#pricing"
    get "features", to: "pages#features"
    get "blog", to: "pages#blog"
    get "blog_show", to: "pages#blog_show"
    get "blog_category", to: "pages#blog_category"
    get "about", to: "pages#about"
    get "terms", to: "pages#terms"
    get "privacy_policy", to: "pages#privacy_policy"
    get "signup", to: "pages#signup"
    get "signin", to: "pages#signin"
    get "help", to: "pages#help"
    get "chat_new", to: "pages#chat_new"
    get "chat_show", to: "pages#chat_show"
  end

  if Rails.env.development?
    # Visit the start page for Rails UI any time at /railsui/start
    mount Railsui::Engine, at: "/railsui"
  end

  resources :besm_references, only: [ :index ] do
    collection do
      get :attributes
      get :defects
      get :enhancements
      get :limiters
      get :weapon_enhancements
      get :weapon_limiters
      get :search
    end
  end

  resources :besm_attributes
  resources :besm_defects
  resources :attribute_enhancements
  resources :attribute_limiters
  resources :weapon_enhancements
  resources :weapon_limiters

  resources :character_sheets do
    resources :character_point_adjustments, only: [ :create, :destroy ]
    resources :money_adjustments, only: [ :create, :destroy ]
    resources :character_attributes, only: [ :create, :update, :destroy ] do
      member do
        patch :publish
      end
    end
    resources :character_defects, only: [ :create, :update, :destroy ]
    resources :equipment_entries, only: [ :create, :update, :destroy ] do
      member do
        patch :publish
      end
    end
    member do
      patch :append_note
      patch :update_notes
    end
  end

  root action: :index, controller: "character_sheets"
  get "up" => "rails/health#show", as: :rails_health_check
end
