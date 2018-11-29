class GroupsController < ApplicationController
  # グループの閲覧制限・編集制限
  before_action :owner, only:[:edit, :update, :destroy]

  def owner
    unless
      @owner = UserGroup.find_by(entry: true, owner: true,  group_id:  params[:id], user_id: current_user.id)
      redirect_to root_path
    end
  end
  # ーーーーーーーーーーーーーーー
  def index
    @groups = Group.all
  end

  def new
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @new_group = Group.new
  end
  def create
    if UserGroup.where(user_id: current_user.id, creater: true).count >= 3
      redirect_to root_path , notice: "作成できるグループは上限３つまで。"
    else
      @new_group = Group.new(group_params)
      @new_group.save
      @user_group = UserGroup.new(user_id: current_user.id, group_id: @new_group.id, entry: true, owner: true, creater: true)
      @user_group.save
      redirect_to group_path(@new_group)
    end
  end

  def show
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @group = Group.find(params[:id])
    @joingroups = @group.user_groups.where(entry: true).count
    @favogroups = @group.favorites.count
    @popularity = @group.recipes.order(views: "DESC").limit(3)
    @group_recipes = @group.recipes.order(created_at: "DESC").page(params[:group]).per(18)
    if @group.restrict && !UserGroup.find_by(entry: true,  group_id: @group.id, user_id: current_user.id)
      redirect_to root_path
    end
  end

  def edit
    #ーーーーーーーーーーサイドバーに必要な変数ーーーーーーーーーーーーーーーーーー
    @favorite_group = Favorite.where(user_id: current_user.id)#お気に入り登録しているグループの情報
    #ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
    @group = Group.find(params[:id])
    @invite_group = UserGroup.new
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to root_path, notice: "グループを削除しました"
  end
  # 招待
  def invite
    if UserGroup.find_by(group_id: params[:group_id], user_id: params[:search_user_id])
      flash[:notice] = "このユーザーはすでにグループに登録されています。"
    else
      @invite_group = UserGroup.new(group_id: params[:group_id], user_id: params[:search_user_id])
      @invite_group.save
    end
    redirect_to edit_group_path(params[:group_id])
  end
  # 参加
  def join
    if UserGroup.find_by(group_id: params[:group_id], user_id: current_user.id)
      flash[:notice] = "すでにグループに登録済みです。"
    else
      join_group = UserGroup.new(user_id: current_user.id, group_id: params[:group_id], entry: true)
      join_group.save
    end
    redirect_to group_path(params[:group_id])
  end

  def search
    @group = Group.find(params[:group_id])
    @user_search = User.search(params[:search])
  end
  private
    def group_params
      params.require(:group).permit(:group_name, :group_image, :lock, :restrict)
    end
end
