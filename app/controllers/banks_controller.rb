class BanksController < ApplicationController
  before_action :current_user

  def new
    @bank = Bank.new
  	@user = User.find_by_id(session[:user_id])
  end

  def create
    #binding.pry

  	if params[:user_id].to_i != @current_user.id
  		redirect_to all_photos_path
  	else



  	user = User.find_by_id(@current_user.id)

      if (user.balanced_href.empty?)
        user_b = Balanced::Customer.new(:name => "#{user.firstname} #{user.lastname}", :meta => {:database_id => user.id}).save
        user.update_attribute(:balanced_href, user_b.attributes[:href])
      end


  	bank_account = Balanced::BankAccount.new(
		  :account_number => params[:account_number],
		  :account_type => 'checking',
		  :name => "#{user.firstname} #{user.lastname}",
		  :routing_number => params[:routing_number]
		).save

    puts bank_account.inspect

  	bank_account.associate_to_customer(user.balanced_href)

  	bank = Bank.create(:user_id => user.id, :balanced_href => bank_account.attributes[:href])
    #binding.pry


      flash[:success] = "Successfully added bank account"
  		redirect_to new_user_photo_path(@current_user.id)
  	end


  end



  private
  def bank_params
    params.require(:bank).permit(:balanced_href, :user_id)
  end
end
