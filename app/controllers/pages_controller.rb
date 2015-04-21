class PagesController < ApplicationController
	def home
		@entry=Entry.new
		@entries=current_user.entries.all
		
	end
end
