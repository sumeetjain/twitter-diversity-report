class PublicController < ApplicationController
  def index
  end

#Don't see anywhere where this method is actually called
  def failure
    redirect_to "/auth/twitter"
  end

#Upon returning from Twitter authentication, finds or creates user id in database
#
#If user id in database, redirects to profile edit
  def returnFromAuth
    session[:screen_name] = oauth_hash['info']['nickname']
    session[:twitter_id] = oauth_hash['uid'].to_i
    binding.pry

    user = User.find_or_create_by(twitter_id:(session[:twitter_id]))

    if user
      redirect_to "/users/#{session[:screen_name]}/edit"
    end
  end

  def result
  end

  def logout
    session.clear
    redirect_to "/"
  end


  protected
    def oauth_hash
      request.env['omniauth.auth']
    end

end
