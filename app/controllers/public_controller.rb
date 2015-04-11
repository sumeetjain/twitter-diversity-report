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
    twitter_id = oauth_hash['uid'].to_i
    
    #probably faster way to do this than grabbing all these? But since no other identifier to look up (like username or email), this was the only one I could think of.
    
   User.all.each do |object|
      if object.encrypted_id == twitter_id
        @user = object
        session[:id] = @user.id
      end
    end
    
    # if user isn't in there, makes new user with all attributes at nil and then sets encrypted twitterid
    if @user
      redirect_to "/users/#{session[:screen_name]}/edit"  
    else
      user = User.new() 
      user.encrypted_id = twitter_id
      user.save!
      session[:id] = user.id
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
