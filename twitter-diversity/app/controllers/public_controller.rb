class PublicController < ApplicationController
  
  before_filter :auth_check, only: [:return]

  def home
    render "/public/home"
  end
  
  def call 
  end
  
  def auth_check
    # ouath_hash = request.env['omniauth.auth']
    if oauth_hash == nil
      redirect_to "/auth/twitter"
    else
      
    end
  end
  
  def failure
    redirect_to "/auth/twitter"
  end
  
  def return
    @username = oauth_hash['info']['nickname']
  end
  
  def result
  end
  
  protected
  
  def oauth_hash
    request.env['omniauth.auth']
  end
  
end
