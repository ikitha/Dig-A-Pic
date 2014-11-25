class OrdersController < ApplicationController


  def index
    if params[:user_id].to_i != session[:user_id]
      #binding.pry
      redirect_to all_photos_path
    end
    #binding.pry
    @user = User.find_by_id(session[:user_id])

    @buyer_orders = Order.where(:buyer_id => session[:user_id])

    @seller_orders = Order.where(:seller_id => session[:user_id])

  end


  def new
  	@photo = Photo.find_by_id(params[:photo_id])
  	@seller = @photo.user
  	@buyer = User.find_by_id(session[:user_id])
  	@order = Order.new
  	@card = Card.new
    #binding.pry

  end

  def create
  
  	@photo = Photo.find_by_id(card_params[:photo_id])
  	@seller = @photo.user
  	@buyer = User.find_by_id(session[:user_id])

  	merchant_b = Balanced::Customer.fetch(@seller.balanced_href)

  	#binding.pry

  	if @buyer.balanced_href.empty?


  		buyer_b = Balanced::Customer.new(:name => "#{@buyer.firstname} #{@buyer.lastname}", :meta => {:database_id => @buyer.id}).save

  		@buyer.update_attribute(:balanced_href, buyer_b.attributes[:href])

  		card_buyer_b = Balanced::Card.new(:cvv => card_params[:cvv], :expiration_month => card_params[:expiration_month], :expiration_year => card_params[:expiration_year], :number => card_params[:number]).save

  		card_buyer_b.associate_to_customer(buyer_b.attributes[:href])

  		@card = Card.create(:user_id => @buyer.id, :balanced_href => card_buyer_b.attributes[:href])



  	elsif @buyer.cards.empty?

  		buyer_b = Balanced::Customer.fetch(@buyer.balanced_href)

  		card_buyer_b = Balanced::Card.new(:cvv => card_params[:cvv], :expiration_month => card_params[:expiration_month], :expiration_year => card_params[:expiration_year], :number => card_params[:number]).save

  		card_buyer_b.associate_to_customer(buyer_b.attributes[:href])

  		@card = Card.create(:user_id => @buyer.id, :balanced_href => card_buyer_b.attributes[:href])

  	else
  	
  		card_buyer_b = Balanced::Card.fetch(@buyer.cards[0].balanced_href)
  	
  	end

  	bank_accounts_seller_b = Balanced::BankAccount.fetch(@seller.banks[0].balanced_href)
  	marketplace_bank_account = Balanced::Marketplace.mine.owner_customer.bank_accounts.first

  	credit_amount = @photo.price*0.70

  	order_b = merchant_b.create_order

  	order_b.debit_from(
		  :source => card_buyer_b,
		  :amount => @photo.price*100
		)

		order_b.credit_to(
		  :destination => bank_accounts_seller_b,
		  :amount => credit_amount*100
		)

		
		order_b.credit_to(
	    :destination => marketplace_bank_account,
	    :amount => (@photo.price - credit_amount)*100
		)

    #binding.pry

		@order = Order.create(:buyer_id => @buyer.id, :seller_id => @seller.id, :photo_id => @photo.id, :balanced_href => order_b.attributes[:href])

  	#puts card_params

  	#binding.pry
  	

  	redirect_to all_photos_path


  end


  private
  def card_params
    params.permit(:number, :expiration_month, :expiration_year, :cvv, :photo_id)
  end
end
