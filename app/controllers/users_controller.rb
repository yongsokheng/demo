class UsersController < ApplicationController

	def index
		@users=User.paginate(page: params[:page])
	end

	def new
		if logged_in?
			redirect_to root_url
		else
			@user=User.new
		end
		
		
	end

	# ajax jquery

	def show
		@user=User.find(params[:id])
		@entry=Entry.new
		@entries=@user.feed.paginate(page: params[:page])
	end

	def create
		@user = User.new(user_params)

	  	if @user.save
	  		
	  		log_in @user
	  		redirect_to root_url
	  	else
	  		render 'new'
	  	end	
		
	end

	def following
	    @title = "Following"
	    @user  = User.find(params[:id])
	    @users = @user.following.paginate(page: params[:page])
	    render 'show_follow'
  	end

  	def followers
	    @title = "Followers"
	    @user  = User.find(params[:id])
	    @users = @user.followers.paginate(page: params[:page])
	    render 'show_follow'
  	end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
