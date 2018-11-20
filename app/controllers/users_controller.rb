class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if
      @user == current_user
    else
      redirect_to user_path(current_user)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user)
    else
      render :action => "edit"
    end
  end
  def history
    @user = User.find(current_user.id)
  end

  private
    def user_params
         params.require(:user).permit(:name, :user_image, :mail)
    end
end
