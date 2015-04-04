class ResultsController < ApplicationController
  
  def current
    @twitter_handle = params[:screen_name]
    
    client = Result.client
    
    demo_hash = Result.build_result_hash2(client, @twitter_handle)

    result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: demo_hash)
    
    redirect_to "/results/#{result.id}"
  end

  def create
    client = Result.client
    @twitter_handle = params[:twitter_handle]
    
    demo_hash = Result.build_result_hash2(client, @twitter_handle)

    result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: demo_hash)
    
    if session[:screen_name] == nil
      redirect_to "/reroute"
      session[:result] = result
    else
      redirect_to "/results/#{result.id}"
    end
  end
  
  def view
    session[:searched_twitter_handle] = nil
      @result = Result.find(params[:id])  
  end
  
  def reroute
    binding.pry
  end
  
end