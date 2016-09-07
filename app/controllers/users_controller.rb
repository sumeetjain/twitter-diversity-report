class UsersController < ApplicationController
  def index
    @gender_chart = User.where.not(gender: '').group(:gender).count
    @ethnicity_chart = User.where.not(ethnicity: '').group(:ethnicity).count
    @education_chart = User.where.not(education: '').group(:education).count
    @orientation_chart = User.where.not(orientation: '').group(:orientation).count
    @income_chart = {
      'Less than $25k per year' => User.where('income < 25000').count,
      'Between $25k and $50k per year' => User.where('income >= 25000 AND income < 50000').count,
      'Between $50k and $100k per year' => User.where('income >= 50000 AND income < 100000').count,
      'More than $100k per year' => User.where('income >= 100000').count
    }
    @age_chart = {
      '<18' => User.where('age < 18').count,
      '18-24' => User.where('age >= 18 AND age < 25').count,
      '25-34' => User.where('age >= 25 AND age < 35').count,
      '35-44' => User.where('age >= 35 AND age < 45').count, 
      '45-54' => User.where('age >= 45 AND age < 55').count, 
      '55+' => User.where('age >= 55').count
    }
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by twitter_id: (session[:twitter_id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to "/users/#{session[:screen_name]}/edit"

    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to "/users/#{session[:screen_name]}/edit"

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to new_user_path
  end

  private
    def user_params
      params.require(:user).permit(:twitter_id, :age, :income, :education, :ethnicity, :gender, :orientation)
    end
end
