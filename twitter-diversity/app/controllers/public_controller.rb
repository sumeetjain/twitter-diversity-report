class PublicController < ApplicationController
  
  def home
    render "/public/home"
  end
  
  def call 
  end
  
  def return
    @username = oauth_hash['info']['nickname']
    binding.pry
  end
  
  def result
  end
  
  protected
  
  def oauth_hash
    request.env['omniauth.auth']
  end
  
end
