class BanksController < ApplicationController
  def new
  	@user = User.find_by_id(session[:user_id])
  end

  def create
  	if bank_params[:user_id] != session[:user_id]
  		redirect_to all_photos_path
  	else

  	user = User.find_by_id(session[:user_id])
  	bank_account = Balanced::BankAccount.new(
		  :account_number => bank_params[:account_number],
		  :account_type => 'checking',
		  :name => "#{user.firstname} #{user.lastname}",
		  :routing_number => bank_params[:routing_number]
		).save

  	bank_account.associate_to_customer(user.balanced_href)

  	bank = Bank.create(:user_id => user.id, :balanced_href => bank_account.attributes[:href])




  		redirect_to all_photos_path
  	end


  end



  private
  def bank_params
    params.permit(:account_number, :routing_number, :user_id)
  end
end
