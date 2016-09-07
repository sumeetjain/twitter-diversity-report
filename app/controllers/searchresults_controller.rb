class SearchresultsController < ApplicationController
  def index
    client = Searchresult.client
    @testedfriends = Searchresult.testedfriends(client, 'hul')
    # binding.pry
  end

end
