class PublicController < ApplicationController
  
  def home
    render "/public/home"
  end
  
  def call 
  end
  
  def return
    render "public/return"
    # params returned here include oatuh_token and oauth_verifier. These will(probably) be used to ensure that someone can only fill out a form with their own information / for their own handle
  end
  
  def result
  end
  
end
