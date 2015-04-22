class EntriesController < ApplicationController
	def create
		@entry=current_user.entries.build(entry_params)
		@entry.save # true or false
		@post=Entry.first
		
		# if @entry.save
		# 	flash[:success]='Entry posted.'
		# 	redirect_to root_url
		# else
		# 	@entries=current_user.feed.paginate(page: params[:page])
		# 	render 'pages/home'
		# end
		
	end

	def show
		@entry=current_user.entries.find(params[:id])
		@comment=@entry.comments.build
		@comments=Comment.where("user_id=? and entry_id=?", current_user,params[:id])
		store_location
	end

	def destroy
		entry=Entry.find(params[:id]).destroy
		flash.now[:success]="Post deleted"
		redirect_to request.referrer || root_url

	end

	def edit
		@entry=Entry.find(params[:id])
	end

	def update
		@entry=Entry.find(params[:id])
		if @entry.update_attributes(entry_params)
			flash[:success]='Update success'
			redirect_back_or(root_url)
		else
			render 'edit'
		end

	end

	private
		def entry_params
			params.require(:entry).permit(:title,:body)
			
		end
end
