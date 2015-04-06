class ApplicationController < ActionController::Base
  protect_from_forgery # adds tokens to forms, but only erb form_for and form_tag
  
end
