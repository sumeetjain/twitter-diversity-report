Rails.application.routes.draw do

    ########### PUBLIC ############################

    root to: 'public#index' #if they click search, sends that name to post:results

    get "/logout" => 'public#logout'

    ########## USERS ##############################

    get "/users/:screen_name/edit" => 'users#edit' #protected

    get "/users/self" => 'searchresults#showself'

    get "/users/self/result" => 'users#selfresult'

    resources :users

    ########## RESULTS ###########################
    post "/reroute" => 'searchresults#reroute'

    get "/result" => 'searchresults#index'

    get "/result/:twitter_handle" => 'searchresults#reroute'

    ######### OMNIAUTH ###########################

    get "/auth/twitter/callback" => "public#returnFromAuth"

    get "/auth/failure" => "public#failure"

end
