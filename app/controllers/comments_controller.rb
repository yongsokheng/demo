class CommentsController < ApplicationController
	def create
		@comment=current_user.comments.build(comment_params)
		@comment.save
		@post_comment=Comment.last
	end

	def destroy
		comment=Comment.find(params[:id]).destroy
		flash.now[:success]='Comment deleted'
		redirect_to request.referrer || root_url
		
	end

	def edit
		@comment=Comment.find(params[:id])
		
	end

	def update
		@comment=Comment.find(params[:id])
		if @comment.update_attributes(comment_param)
			flash[:success]='Comment update'
			redirect_back_or(root_url)
		else
			render 'edit'
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:entry_id, :comment)
			
		end

		def comment_param
			params.require(:comment).permit(:comment)
			
		end
end
