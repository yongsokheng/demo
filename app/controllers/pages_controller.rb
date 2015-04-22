class PagesController < ApplicationController
	def home
		@entry=Entry.new
		if logged_in? 
			@entries=current_user.entries.all
			#store_location
		end
		
	end
end
