Rails.application.routes.draw do
  devise_for :members, controllers: {
    sessions:      'member/sessions' ,
    registrations: 'member/registrations',
  }

  root to: 'home#launchpad'

  resources :teams do
    resources :projects
    resources :events, only: [:index]
  end

  resources :comments, only: [:new, :create, :edit, :update, :destroy] do
    member do
      post :like
      post :unlike
    end
  end

  scope :module => :project do
    resources :projects, only: [:show] do
      resources :todos do
        member do
          post :recover
          post :run
          post :pause
          post :complete
          post :reopen
        end
      end
    end
  end
end
