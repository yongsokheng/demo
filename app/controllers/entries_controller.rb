class EntriesController < ApplicationController
	before_action :login_user, only: [:create, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def create
		@entry=current_user.entries.build(entry_params)
		@entry.save
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

		@entry=Entry.find_by(id: params[:id])
		@comment=Comment.new
		@comments=Comment.where("entry_id=?", params[:id])
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

		def login_user
			unless logged_in?
				flash[:danger] = "Please log in."
				redirect_to login_url
			end	
		end

		def correct_user
			entry=current_user.entries.find_by(id: params[:id])
			redirect_to root_url if entry.nil?
			
		end
end
