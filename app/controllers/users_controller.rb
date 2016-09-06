class UsersController < ApplicationController
  def index
    @users = User.all
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
