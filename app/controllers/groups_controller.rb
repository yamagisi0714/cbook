class GroupsController < ApplicationController
  # グループの閲覧制限・編集制限
  before_action :cook, only:[:show]
  before_action :owner, only:[:edit, :update, :destroy]

  def cook
    unless UserGroup.find_by(entry: true,  group_id:  params[:id], user_id: current_user.id)
      redirect_to root_path
    end
  end
  def owner
    unless UserGroup.find_by(entry: true, owner: true,  group_id:  params[:id], user_id: current_user.id)
      redirect_to root_path
    end
  end
  # ーーーーーーーーーーーーーーー
  def index
    @groups = Group.all
    @group_apply = UserGroup.new(user_id: current_user.id, group_id: @new_group.id)
    @group_apply.save
    redirect_to groups_path
  end

  def new
    @new_group = Group.new
  end
  def create
    @new_group = Group.new(group_params)
    @new_group.save
    @user_group = UserGroup.new(user_id: current_user.id, group_id: @new_group.id, entry: 'true', owner: 'true')
    @user_group.save
    redirect_to group_path(@new_group)
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
    @member = UserGroup.where(entry: true,  group_id:  params[:id], nil)
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to books_path, notice: "削除しました"
  end
  # 申請
  def apply
  end
  private
    def group_params
      params.require(:group).permit(:group_name, :group_image)
    end
end
