class GalleriesController < ApplicationController
	before_filter :login_required
	require 'mime/types'
	
  # GET /galleries
  # GET /galleries.xml
  def index
    @galleries = Gallery.all
    render :layout => 'application'
  end

  # GET /galleries/1
  # GET /galleries/1.xml
  def show
    @gallery = Gallery.find(params[:id])
		@user = User.find(@gallery.user_id)
		if current_user.id != @user.id && !current_user.has_role?('admin')
			flash[:error] = 'You do not have access to that gallery. Please choose one of yours.'
    	redirect_to member_path(current_user)
    end
    @cart = find_cart
		@sizes = Price.all(:order => 'position')
		rescue ActiveRecord::RecordNotFound 
			logger.error("Attempt to access invalid gallery #{params[:photo_id]}") 
			flash[:notice] = "That gallery doesn't seem to exist :(" 
			redirect_back_or_default(member_path(current_user))
  end

  # GET /galleries/new
  # GET /galleries/new.xml
  def new
    @gallery = Gallery.new
    @user = User.find(params[:user_id])
    render :layout => 'application'
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
    render :layout => 'application'
  end

  # POST /galleries
  # POST /galleries.xml
  def create
  	@user = User.find(params[:gallery][:user_id])
    @gallery = @user.galleries.new(params[:gallery])

    respond_to do |format|
      if @gallery.save
        flash[:notice] = 'Gallery was successfully created.'
        format.html { redirect_to(edit_gallery_path(@gallery)) }
        format.xml  { render :xml => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.xml
  def update
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        flash[:notice] = 'Gallery was successfully updated.'
        format.html { redirect_to(@gallery) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.xml
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to(galleries_url) }
      format.xml  { head :ok }
    end
  end
  
  def add_to_cart
    photo = Photo.find(params[:photo_id])
 		@user = User.find(current_user.id)
    @cart = find_cart                   
    @cart.add_photo(photo, params[:quantity].to_i, params[:size][:option])
    respond_to do |format| 
			format.js 
		end
    rescue ActiveRecord::RecordNotFound 
			logger.error("Attempt to access invalid photo #{params[:photo_id]}") 
			flash[:notice] = "Invalid Photo" 
			redirect_back_or_default(member_path(current_user))
   end
  
  def empty_cart 
		session[:cart] = nil
		@cart = find_cart 
		respond_to do |format| 
			format.js 
		end 
	end 
	
	def remove_from_cart
    @cart = find_cart
    @current_item = @cart.remove_photo(params[:photo], params[:size])
	end


  private 
		
		def find_cart 
			session[:cart] ||= Cart.new 
		end 

  
end
