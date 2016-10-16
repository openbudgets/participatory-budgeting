Rails.application.routes.draw do
  namespace 'admin' do
    resources :proposals

    root 'proposals#index'
  end

  namespace 'voting' do
    resources :proposals, only: [:index, :show, :update] do
      collection do
        get 'summarize'
      end
    end
  end

  namespace 'monitoring' do
    resources :proposals, only: [:index, :show] do
      collection do
        get 'summarize'
      end
      resources :comments, only: [:create]
    end

    root 'proposals#index'
  end

  resources :voters, only: [:new, :create, :update] do
    collection do
      get 'verification', to: 'voters#verify', as: :verify
      get 'signout'
    end
  end

  get '/terms-of-service', to: 'pages#terms_of_service'
  get '/privacy-policy',   to: 'pages#privacy_policy'

  root 'pages#home'
end
