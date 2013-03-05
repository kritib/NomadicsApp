class RelationshipsController < ApplicationController

	def create
		Relationship.create!(user_id: @current_user.id,
                         friend_id: params[:friend_id])
		Relationship.create!(friend_id: @current_user.id,
                         user_id: params[:friend_id])

		redirect_to user_path(params[:friend_id])
	end
end
