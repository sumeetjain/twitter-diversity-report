class ResultsController < ApplicationController
  
  def current
    if params[:screen_name] == nil || params[:screen_name] == ""
      flash[:message] = "Did you press enter too soon? We didn't see a Twitter handle. Try again below:"
      redirect_to "/"
    else
      params[:screen_name][0] = "" if params[:screen_name][0] == "@"
      @twitter_handle = params[:screen_name]
      
      @result = Result.new(searched_handle: @twitter_handle)
    
      demo_hash = @result.build_result_hash
      
      if demo_hash[:succeeded]
        if @result.demo_hash == {}
          flash[:message] = "Oh no! @#{params[:screen_name]} is not following anyone who's filled out information with us. Try another search:" 
          redirect_to "/"
        else
          @result.save
          redirect_to "/results/#{@result.id}"
        end
      else
        flash[:message] = demo_hash[:error_msg]
        redirect_to "/"
      end
    end
  end


  def create
    if params[:twitter_handle] == nil || params[:twitter_handle] == ""
      flash[:message] = "Oops. You didn't enter any information."
      redirect_to "/"
    else
      params[:twitter_handle][0] = "" if params[:twitter_handle][0] == "@"
      @twitter_handle = params[:twitter_handle]
      
      @result = Result.new(searched_handle: @twitter_handle)
      demo_hash = @result.build_result_hash
      
      if demo_hash[:succeeded]
        if @result.demo_hash == {}
          flash[:message] = "Oh no! @#{params[:screen_name]} is not following anyone who's filled out information with us. Try another search:" 
          redirect_to "/"
        else
          @result.save
          
          session[:searched_for] = params[:twitter_handle]
          session[:result] = @result
          
          if session[:screen_name] == nil
            redirect_to "/reroute"
          else
            redirect_to "/results/#{@result.id}"
          end # if loop for redirect fill-out info prompt
        end
      else
        flash[:message] = demo_hash[:error_msg]
        redirect_to "/"
      end
    end # if loop for empty query vs full query
  end # method
  
  def view
      @result = Result.find(params[:id]) 
    session[:searched_for] = nil
    session[:result] = nil 
  end
  
  def reroute # TODO check if lines 81-86 are even needed.
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