class CommentsController < ApplicationController
	before_action :login_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def create
		@comment=current_user.comments.build(comment_params)
		@comment.save

	end

	def destroy
		@comment=Comment.find(params[:id]).destroy
		
	end

	def edit
		@comment=Comment.find(params[:id])
		
	end

	def update
		@comment=Comment.find(params[:id])
		@comment.update_attributes(comment_param)
			
	end

	def cancel
		@comment=Comment.find(params[:id])
		
	end

	private
		def comment_params
			params.require(:comment).permit(:entry_id, :comment)
			
		end

		def comment_param
			params.require(:comment).permit(:comment)
			
		end

		def correct_user
			comment=current_user.comments.find_by(id: params[:id])
			redirect_to root_url if comment.nil?
			
		end

end
