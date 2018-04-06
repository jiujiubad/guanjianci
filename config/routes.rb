Rails.application.routes.draw do
  root 'welcome#index'

  resources :guanggaos do
    collection do
      post :gg_update
    end
  end
end
