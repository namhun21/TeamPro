class FollowsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        Follow.create(followed_id: params[:followed_id],follower_id: current_user.id)
        redirect_back fallback_location: root_path
    end
    
    def destroy
        Follow.find_by(followed_id: params[:id], follower_id: current_user.id).destroy
        redirect_back fallback_location: root_path
    end
end
