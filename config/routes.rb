MovieMania::Application.routes.draw do

    get "/contents" => "movies#resource_list"   #get all movies and seasons
    get "/users/:id/contents" => "users#all_contents" #an user's all contents stored in a library
    post "/users/:id/purchase" => "users#purchase"  #an user performing purchase

    resources :movies

    resources :seasons do
      resources :episodes, only: [:index]
    end

end
