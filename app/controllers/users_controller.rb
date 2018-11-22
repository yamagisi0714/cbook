class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    @join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
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
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    @join_group = UserGroup.where(user_id: current_user.id, entry: true)#参加中のグループ
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @user = User.find(current_user.id)
  end

  private
    def user_params
         params.require(:user).permit(:name, :account, :user_image, :mail)
    end
end
