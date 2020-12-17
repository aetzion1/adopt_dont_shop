Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  resources :shelter

  # get "/shelters", to: "shelters#index"
  # get "/shelters/new", to: "shelters#new"
  # get "/shelters/:id", to: "shelters#show"
  # delete "/shelters/:id", to: "shelters#destroy"
  # post "/shelters", to: "shelters#create"
  # get "/shelters/:id/edit", to: "shelters#edit"
  # patch "/shelters/:id", to: "shelters#update"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"

  # get "/applicants/new", to: "applicants#new"
  get "/applicants/:applicant_id/applications/new", to: "applicant_applications#new"
  post "/applicants/:applicant_id/applications", to: "applicant_applications#create"

  get "/applications", to: "applications#index"
  get "/applications/new", to: "applications#new"
  post "/applicants", to: "applicants#create"
  get "/applications/:id", to: "applications#show"
  get "/applications/:id/edit", to: "applications#edit"
  patch "/applications/:id", to: "applications#update"

  post "/adoptions", to: "adoptions#create"
  patch "/adoptions/:id", to: "adoptions#update"

  get 'admin/applications', to: "admin/applications#index"
  get 'admin/applications/:id', to: "admin/applications#show"
  patch 'admin/applications/:id', to: "admin/applications#update"
  
end