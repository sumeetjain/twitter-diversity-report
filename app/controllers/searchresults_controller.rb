class SearchresultsController < ApplicationController
  def reroute
    session[:twitter_handle] = params[:twitter_handle]
    if session[:screen_name] != nil
      redirect_to '/result'
    end
  end

  def showself
    session[:twitter_handle] = session[:screen_name]
    redirect_to '/result'
  end

  def posttotwitter
    client = Searchresult.client
    if session[:screen_name] == session[:twitter_handle]
      client.update("Hey friends! Take this Twitter Diversity Quiz and find out help me find out how diverse my social network is! http://localhost:3000/auth/twitter")
    else
      client.update("Hey #{session[:twitter_handle]}, take this Twitter Diversity Quiz and find out how diverse our social network is! http://localhost:3000/auth/twitter")
    end
    redirect_to "/"
  end

  def index
    client = Searchresult.client
    if session[:twitter_handle] == ""
      flash[:message] = "Did you press enter too soon? We didn't see a Twitter handle. Try again."
      redirect_to "/"

    else
      begin
        @testedfriends = Searchresult.testedfriends(client, session[:twitter_handle])
        rescue Twitter::Error::NotFound
          flash[:message] = "Hmmm...Twitter didn't recognize that handle. Try again."
          return redirect_to "/"
        rescue Twitter::Error::Unauthorized
          flash[:message] = "Something's wrong with that Twitter account. It may be suspended. Try another search."
          return redirect_to "/"
        rescue Twitter::Error::EnhanceYourCalm, Twitter::Error::TooManyRequests,
               Twitter::Error::InternalServerError, Twitter::Error::BadGateway,
               Twitter::Error::ServiceUnavailable, Twitter::Error::GatewayTimeout,
               Twitter::Error::Forbidden
        flash[:message] = "Looks like something's wrong on Twitter's end. Try back in a few minutes."
        return redirect_to "/"
      end
      @ethnicity_chart =   @testedfriends.joins(:ethnicities).select("ethnicities.value").group("ethnicities.value").count
      @gender_chart = @testedfriends.joins(:genders).select("genders.value").group("genders.value").count
      @orientation_chart =   @testedfriends.joins(:orientations).select("orientations.value").group("orientations.value").count
      @education_chart = @testedfriends.where.not(education: '').group(:education).count
      @income_chart = {
        'Less than $25k per year' => @testedfriends.where('income < 25000').count,
        'Between $25k and $50k per year' => @testedfriends.where('income >= 25000 AND income <  50000').count,
        'Between $50k and $100k per year' => @testedfriends.where('income >= 50000 AND income <   100000').count,
        'More than $100k per year' => @testedfriends.where('income >= 100000').count
      }
      @age_chart = {
        '<18' => @testedfriends.where('age < 18').count,
        '18-24' => @testedfriends.where('age >= 18 AND age < 25').count,
        '25-34' => @testedfriends.where('age >= 25 AND age < 35').count,
        '35-44' => @testedfriends.where('age >= 35 AND age < 45').count,
        '45-54' => @testedfriends.where('age >= 45 AND age < 55').count,
          '55+' => @testedfriends.where('age >= 55').count
      }
    end
  end

end
