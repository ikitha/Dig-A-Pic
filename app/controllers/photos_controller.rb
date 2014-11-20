class PhotosController < ApplicationController
	before_action :current_user
	before_action :confirm_logged_in, only: [:new, :create, :edit, :show]
  

  def index
  end

  def new
  	@photo = Photo.new
  end

  def create
  	@photo = Photo.create(product_params)
    if @photo.save
      flash[:success] = "Photo created"
      redirect_to photos_path
    else
      render :new
    end
  end

  def edit
  	@photo = Photo.find(params[:id])
  end

  def show
  	@photo = Photo.find(params[:id])
  end

  def update
  end

  def destroy
  end

    private
  def photo_params
    params.require(:photo).permit(:title, :url, :price)
  end
end
