class UsersController < ApplicationController

  def index
    #if session[:is_admin] != true
    #  redirect_to('/home')
    #end
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    #@session_id = session[]
    #prevent_user(@user)
  end

  def edit
    if session[:user_id].to_i != params[:user_id].to_i 
      redirect_to all_photos_path
    else
      @user = User.find_by_id(params[:id])
    end
    #prevent_user(@user)
  end

   def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if(@user.save)
      session[:user_id] = @user.id
      #session[:is_admin] = @user.is_admin
      flash[:success] = "Your profile is updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
   end

  def destroy
    user = User.find_by_id(params[:id])
    user.destroy
    redirect_to '/index'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end