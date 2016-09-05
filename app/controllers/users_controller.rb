class UsersController < ApplicationController
  def index
    @gender_chart = User.where.not(gender: '').group(:gender).count
    @ethnicity_chart = User.where.not(ethnicity: '').group(:ethnicity).count
    @education_chart = User.where.not(education: '').group(:education).count
    @orientation_chart = User.where.not(orientation: '').group(:orientation).count
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(edit_user_path(@user))
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to(edit_user_path(@user))
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
