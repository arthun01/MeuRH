Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt-BR|es/ do
    devise_for :users, controllers: { registrations: 'users/registrations' }
    
    resources :roles, except: [:show]
    resources :employees do
      collection do
        get :export
      end
    end
    resources :messages, only: [:index, :create]
    resources :tasks

    # Defines the root path route ("/")
    root "dashboard#index"
  end
end
