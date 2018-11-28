class UsersController < ApplicationController
  before_action :correct_user, only:[:show, :edit, :update, :destroy]

  def correct_user
    @user = User.find(params[:id])
      unless @user == current_user
        redirect_to root_path
      end
  end

  def show
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  	@user = User.find(params[:id])
    fovorite = current_user.favorites.pluck(:group_id)
    @recipes = Recipe.where(group_id: fovorite).order(created_at: "DESC").page(params[:favorite]).per(10)
    @allrecipes = Recipe.order(created_at: "DESC").limit(20)
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
    @user.update(user_params)
    redirect_to user_path(current_user.id)
  end
  def destory
    user.find(params[:id])
    user.destory
    redirect_to root_path, notice: "削除しました"
  end
  def history
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @user = User.find(current_user.id)
    correct_user = User.find([:user_id])
    unless correct_user == current_user
      redirect_to root_path
    end
  end
  def stock
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @user = User.find(params[:user_id])
    correct_user = User.find([:user_id])
    unless correct_user == current_user
      redirect_to root_path
    end
    stock = current_user.keeps.pluck(:recipe_id)
    @recipe = Recipe.where(id: stock)
    @stock_recipe = @recipe.find(Keep.group(:recipe_id).order('created_at desc').pluck(:recipe_id))
  end

  private
    def user_params
         params.require(:user).permit(:name, :account, :user_image, :mail)
    end
end
