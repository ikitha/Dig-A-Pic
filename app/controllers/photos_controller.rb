class PhotosController < ApplicationController
  before_action :check_user, only: [:edit]
	before_action :current_user, except: [:all]
  before_action :categories, only: [:new, :create, :show, :edit, :update]
	before_action :confirm_logged_in, only: [:new, :create, :edit, :show, :index]
  


  def index
    @photos = @current_user.photos
  end


  def all
    #binding.pry
    @portraits = Category.find(1).photos.reverse.first(9)
    @bw = Category.find(2).photos
    @landscape = Category.find(3).photos
    #binding.pry
    @abstract = Category.find(4).photos

    #binding.pry
  end

  def new
  	@photo = @current_user.photos.new
  end

  def create
    if @current_user.banks.empty?
      flash[:error] = "Please link a bank account to receive payment"
      redirect_to new_user_bank_path
    else
      @photo = @current_user.photos.create(photo_params)
      params[:photo][:categories] ||= []
      @photo.categories = []
      @photo.categories << Category.find(params[:photo][:categories])
      if @photo.save
        # split the url 
        # make an api call with HTTParty to get json hash
        # save the width and height to the DB
        photo_meta_data = HTTParty.get("#{@photo.url}-/json/")
        @photo.update_attributes(width: photo_meta_data["width"], height: photo_meta_data["height"])

        flash[:success] = "Photo created"
        redirect_to user_photo_path(@current_user, @photo.id)
      else
        render :new
      end
    end
  end

  def edit
  	@photo = Photo.find(params[:id])
  end

  def show
  	@photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update_attributes(photo_params)
    params[:photo][:categories] ||= []
    @photo.categories = []
    @photo.categories << Category.find(params[:photo][:categories])
    if @photo.save
      flash[:success] = "Photo successfully updated"
      redirect_to user_photo_path(@current_user, @photo.id)
    else
      render :edit
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    flash[:success] = "Photo deleted"
    redirect_to user_photos_path(@current_user)
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :url, :price, :user_id)
  end

  def categories
    @categories = Category.all
  end
end
