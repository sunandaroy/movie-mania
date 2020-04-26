MovieMania::Application.routes.draw do

    get "/contents" => "movies#resource_list"
    get "/users/:id/contents" => "users#all_contents"
    post "/users/:id/purchase" => "users#purchase"

  # Sample resource route with sub-resources:
    resources :seasons do
      resources :episodes, only: [:index]
    end

end
