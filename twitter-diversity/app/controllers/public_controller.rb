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
      redirect "/auth/twitter"
    else
      
    end
  end
  
  def return
    begin
    @username = oauth_hash['info']['nickname']
    rescue
      redirect "/auth/twitter"
    end
  end
  
  def result
  end
  
  protected
  
  def oauth_hash
    request.env['omniauth.auth']
  end
  
end
