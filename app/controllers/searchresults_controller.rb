class SearchresultsController < ApplicationController
  def index
    client = Searchresult.client
    @friends = client.friend_ids("noto-alex-j")
    binding.pry
  end

end
