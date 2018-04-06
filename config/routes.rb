Rails.application.routes.draw do
  root 'guanggaos#index'

  resources :guanggaos do
    collection do
      post :gg_update
      post :clean
    end
  end
end
