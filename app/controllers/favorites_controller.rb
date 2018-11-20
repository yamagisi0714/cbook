class FavoritesController < ApplicationController
  def create
        group = Group.find(params[:group_id])
        favorite = current_user.favorites.new(group_id: group.id)
        favorite.save
        redirect_to group_path(group)
    end
    def destroy
        group = Group.find(params[:group_id])
        favorite = current_user.favorites.find_by(group_id: group.id)
        favorite.destroy
        redirect_to group_path(group)
    end
end
