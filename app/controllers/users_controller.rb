class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only:[:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Whispered Words!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def edit
   # @user = User.find(params[:id])    #moved to correct_user before filter
    if @user.update_attributes(params[:user])
      flash[:success]="Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
    
  end#end of edit
  
   def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end#end of following

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end#end of followers
  
  
  
  def index
    @users = User.paginate(page: params[:page])
  end#end of index
  
  def new
    @user=User.new
  end
  
  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page: params[:page])
  end
  
  
  
  def update
   # @user = User.find(params[:id])   #moved to correct_user before filter
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end #end of update
  
  
  private
 
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
   def admin_user
     redirect_to(root_path) unless (current_user.admin?&&User.find(params[:id])!=current_user)
   end
  
end
