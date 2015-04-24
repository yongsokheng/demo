class EntriesController < ApplicationController
	before_action :login_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def create
		@entry=current_user.entries.build(entry_params)
		@entry.save
		
		# if @entry.save
		# 	flash[:success]='Entry posted.'
		# 	redirect_to root_url
		# else
		# 	@entries=current_user.feed.paginate(page: params[:page])
		# 	render 'pages/home'
		# end
		
	end

	def show

		@entry=Entry.find_by(id: params[:id])
		@comment=Comment.new
		@comments=Comment.where("entry_id=?", params[:id]).paginate(page: params[:page])
		
	end

	def destroy
		@entry=Entry.find(params[:id]).destroy
		respond_to do |format|
			format.html { redirect_to root_url}
			format.js {}
		end
		
	end

	def edit
		@entry=Entry.find(params[:id])
	end

	def update
		@entry=Entry.find(params[:id])
		@entry.update_attributes(entry_params)	

	end

	def cancel
		@entry=Entry.find(params[:id])
		
	end

	private
		def entry_params
			params.require(:entry).permit(:title,:body)
			
		end


		def correct_user
			entry=current_user.entries.find_by(id: params[:id])
			redirect_to root_url if entry.nil?
			
		end

		
end
