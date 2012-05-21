class MicropostsController < ApplicationController
  before_filter :signed_in_user
   before_filter :correct_user,   only: :destroy

  def create
    @micropost=current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

   def destroy
     @user=@micropost.user
    @micropost.destroy
    if (current_user.admin?)
      redirect_to @user
    else
    redirect_to root_path
  end
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      if @micropost.nil?
        if (current_user.admin?)
          @micropost =Micropost.find_by_id(params[:id])
        else
          redirect_to root_path 
        end
      end
      
    end
end