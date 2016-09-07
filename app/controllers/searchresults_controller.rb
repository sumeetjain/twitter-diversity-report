class SearchresultsController < ApplicationController
  def index
    client = Searchresult.client
    @testedfriends = Searchresult.testedfriends(client, params[:twitter_handle])
    @ethnicity_chart = @testedfriends.where.not(ethnicity: '').group(:ethnicity).count
    @education_chart = @testedfriends.where.not(education: '').group(:education).count
    @orientation_chart = @testedfriends.where.not(orientation: '').group(:orientation).count
    @income_chart = {
      'Less than $25k per year' => @testedfriends.where('income < 25000').count,
      'Between $25k and $50k per year' => @testedfriends.where('income >= 25000 AND income < 50000').count,
      'Between $50k and $100k per year' => @testedfriends.where('income >= 50000 AND income < 100000').count,
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
