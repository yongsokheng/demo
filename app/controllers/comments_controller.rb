class CommentsController < ApplicationController
	def create
		@entry=Entry.find(params[:comment][:entry_id])
		@comment=current_user.comments.build(comment_params)
		if @comment.save
			flash[:success]='Comment posted'	
		else
			flash[:danger]='Invalid comment'
		end
		redirect_to @entry
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
		if @comment.update_attributes(comment_params)
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
end
