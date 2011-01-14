class PhotosController < ApplicationController
  #session :cookie_only => false, :only => :create
  skip_before_filter :verify_authenticity_token
  
  def new
  	@photo = Photo.new
  end

  def create
  	@gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.new(:swfupload_file => params[:Filedata])
    if @photo.save
     	render :partial => 'image', :object => @photo
   	else
      render :text => "error"
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
  end

end
