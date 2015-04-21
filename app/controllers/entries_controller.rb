class EntriesController < ApplicationController
	def create
		@entry=current_user.entries.build(entry_params)
		if @entry.save
			flash[:success]='Entry posted.'
			redirect_to root_url
		else
			@entries=[]
			render 'pages/home'
		end
		
	end

	private
		def entry_params
			params.require(:entry).permit(:title,:body)
			
		end
end
