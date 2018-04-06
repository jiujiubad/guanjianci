Rails.application.routes.draw do
  root 'welcome#index'

  resources :guanggaos do
    collection do
      delete :clean
    end
  end
end
