class MemberController < ApplicationController
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