class PagesController < ApplicationController
	def home
		@entry=Entry.new
		if logged_in? 
			@entries=current_user.feed.paginate(page: params[:page])
			store_location
		end
		
	end
end
