class MembersController < ApplicationController
	def create
	end
	def destroy
		member = UserGroup.find(params[:group_id])
        member.destroy
        redirect_back(fallback_location: "groups#edit")
	end

end