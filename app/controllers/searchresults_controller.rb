class SearchresultsController < ApplicationController
  def index
    client = Searchresult.client
    @userinfo = client.userinfo
    binding.pry
  end

end
