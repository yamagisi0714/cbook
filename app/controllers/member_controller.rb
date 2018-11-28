class MemberController < ApplicationController
	before_action :owner

	def owner
		unless
		  @owner = UserGroup.find_by(entry: true, owner: true,  group_id:  params[:id], user_id: current_user.id)
		  redirect_to root_path
		end
	end
	def change
		user = User.find(params[:user_id])
		group = Group.find(params[:group_id])
		status = UserGroup.find_by(user_id: user.id, group_id: group.id)
		if status.owner == true
			status.update(owner: false)
			redirect_back(fallback_location: "groups#edit")
		else status.owner == false
			status.update(owner: true)
			redirect_back(fallback_location: "groups#edit")
		end
	end

	def ban
		group = Group.find(params[:group_id])
		user = User.find(params[:user_id])
		ban = UserGroup.find_by(user_id: user.id, group_id: group.id)
        ban.destroy
        if group.user_groups.count == 0
        	group.destroy
        end
        redirect_back(fallback_location: "groups#edit")
	end

end