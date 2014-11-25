class AccessController < ApplicationController
  #before_action :confirm_logged_in, only: [:home]
  before_action :prevent_login_signup, only: [:signup, :login, :landing, :all]


  def landing

  end

  def login
    
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      user_b = Balanced::Customer.new(:name => "#{@user.firstname} #{@user.lastname}", :meta => {:database_id => @user.id}).save
      @user.update_attribute(:balanced_href, user_b.attributes[:href])
      session[:user_id] = @user.id
      flash[:success] = "You are now logged in!"
      UserMailer.signup_confirmation(@user, root_url()).deliver
      redirect_to all_photos_path
    else
      render :signup
    end
  end

  def reset_password
    @token = params[:token]
    @user = User.find_by :reset_token => @token
    if @user.nil?
      flash[:error] = "Invalid reset token"
      render :login
    else  
      render :reset_password
    end
  end

  #post '/send_reset' => 'user#reset_password'
  def send_reset
    # username in param
    username = params[:username]
    user =  User.find_by username: username
    if user.nil?
      flash[:error] = "No such user:" + username
    else
      # create and save reset token on user
      user.reset_token = (0...16).map { (65 + rand(26)).chr }.join
      user.save
      UserMailer.forgot_password_email(user, root_url() ).deliver
      flash[:success] = "Please check your email for reset instructions ..."
    end
    render :forgot_password
  end

  def update_password
    user_params = params.permit(:username, :password, :password_confirmation)
    @user = User.find_by username: user_params[:username]
    @user.update_attributes(password: user_params[:password], password_confirmation: user_params[:password_confirmation])
    flash[:success] = "Your password has changed, try it out ..."
    render :login
  end

  def attempt_login

    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if !found_user
      flash.now[:alert] = "Invalid username"
      render :login

    elsif !authorized_user
      flash.now[:alert] = "Invalid password"
      render :login

    else
      session[:user_id] = authorized_user.id
      flash[:success] = "You are now logged in."
      redirect_to all_photos_path
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :username, :password, :password_digest, :balanced_href)
  end

end
