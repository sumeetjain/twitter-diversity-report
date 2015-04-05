class ResultsController < ApplicationController
  
  def current
    @twitter_handle = params[:screen_name]
  
    client = Result.client
    
    demo_hash = Result.build_result_hash(client, @twitter_handle)

    result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: demo_hash)
    
    redirect_to "/results/#{result.id}"
  end

  def create
    client = Result.client
    if params[:twitter_handle] == nil || params[:twitter_handle] == ""
      flash[:message] = "Oops. You didn't enter any information."
      redirect_to "/"
    else
      @twitter_handle = params[:twitter_handle]
      begin
        demo_hash = Result.build_result_hash(client, @twitter_handle)
      rescue Twitter::Error::NotFound
        flash[:message] = "Looks like that's one of the few handles that doesn't exist. Try another search:"
        return redirect_to "/"
      end

      result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: demo_hash)
      if session[:screen_name] == nil
        session[:searched_for] = params[:twitter_handle]
        session[:result] = result
        redirect_to "/reroute"
      else
        session[:searched_for] = params[:twitter_handle]
        session[:result] = result
        redirect_to "/results/#{result.id}"
      end
    end
  end
  
  def view
      @result = Result.find(params[:id]) 
    session[:searched_for] = nil
    session[:result] = nil 
  end
  
  def reroute
    if session[:result].demo_hash == {}
      redirect_to "/"
      flash[:message] = "Oh no! @#{session[:searched_for]} is not following anyone who's filled out information with us. Try another search:" 
      session[:searched_for] = nil
      session[:result].destroy
      session[:result] = nil
    else
      render "/results/reroute"
    end
  end
  
end