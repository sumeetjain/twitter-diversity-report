class PublicController < ApplicationController
  
  def home
    render "/public/home"
  end
  
  def call 
  end
  
  def failure
    redirect_to "/auth/twitter"
  end
  
  def return
    session[:screen_name] = oauth_hash['info']['nickname']
    
    user = User.find_by_twitter_handle(session[:screen_name].downcase)
    binding.pry
    if user
      redirect_to "/users/#{user.id}"
    else
      redirect_to "/users/#{session[:screen_name]}/edit"  
    end
  end
  
  def result
  end
  
  protected
  
  def oauth_hash
    request.env['omniauth.auth']
  end
  
end
