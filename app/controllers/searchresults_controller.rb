class SearchresultsController < ApplicationController
  def index
    client = Searchresult.client
    @testedfriends = Searchresult.testedfriends(client, 'rallsyart')
    # binding.pry
  end

end
