class PagesController < ApplicationController
	def home
		@entry=Entry.new
		if logged_in? 
			@entries=current_user.feed.paginate(page: params[:page])
		else
			@user=User.new
		end
		
	end
end
