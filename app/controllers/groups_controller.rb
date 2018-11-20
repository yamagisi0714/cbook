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
    # @group_apply = UserGroup.new(user_id: current_user.id, group_id: @new_group.id)
    # @group_apply.save
    # redirect_to groups_path
  end

  def new
    @new_group = Group.new
  end
  def create
    if UserGroup.where(user_id: current_user.id, creater: true).count >= 3
      redirect_to root_path , notice: "グループ作成は上限３つまでです。"
    end
    @new_group = Group.new(group_params)
    @new_group.save
    @user_group = UserGroup.new(user_id: current_user.id, group_id: @new_group.id, entry: true, owner: true, creater: true)
    @user_group.save
    redirect_to group_path(@new_group)
  end

  def show
    @group = Group.find(params[:id])
    if @group.restrict && !UserGroup.find_by(entry: true,  group_id: @group.id, user_id: current_user.id)
      redirect_to root_path
    end
  end

  def edit
    @group = Group.find(params[:id])
    @invite_group = UserGroup.new
    # @user_search = User.search(params[:search])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to root_path, notice: "削除しました"
  end
  # 招待
  def invite
    if UserGroup.find_by(group_id: params[:group_id], user_id: params[:search_user_id])
      # flash[:notice] = "このユーザーはすでにグループに登録されています。"
    else
      @invite_group = UserGroup.new(group_id: params[:group_id], user_id: params[:search_user_id])
      @invite_group.save
    end
    redirect_to edit_group_path(@group)
  end
  # 参加
  def join
    if UserGroup.find_by(group_id: params[:group_id], user_id: current_user.id)
      # flash[:notice] = "このユーザーはすでにグループに登録されています。"
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
