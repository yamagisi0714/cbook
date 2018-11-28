class MygroupsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
      unless @user == current_user
        redirect_to root_path
      end
  	@joingroups = UserGroup.where(user_id: current_user.id, entry: true).pluck(:group_id)
  	@mygroups = Group.where(id: @joingroups)
    @owner = UserGroup.where(user_id: current_user.id, entry: true, owner: true).pluck(:group_id)
    @ownergroups = Group.where(id: @owner)
  	@waiting = UserGroup.where(user_id: current_user.id, entry: false).pluck(:group_id)
  	@wait_groups = Group.where(id: @waiting)
  end

  def approval
    approval_group = UserGroup.find_by(user_id: current_user.id, group_id: params[:group_id])
    approval_group.update(entry: true)
    redirect_to user_mygroups_path(current_user)
  end

  def withdrawal
    group = Group.find(params[:group_id])
    member = UserGroup.find_by(user_id: current_user.id, group_id: params[:group_id])
    member.destroy
    if group.user_groups.count == 0
      group.destroy
    end
    redirect_back(fallback_location: "mygroups#show")
  end
end
