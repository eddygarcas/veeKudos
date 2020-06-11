Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :slack do
    post "/command", to: "kudos#create", as: "kudos_create"
    post "/leaders", to: "kudos#leaders", as: "kudos_leaders"
    post "/mykudos", to: "kudos#my_kudos", as: "kudos_my_kudos"
   resources :kudos

  end
end
