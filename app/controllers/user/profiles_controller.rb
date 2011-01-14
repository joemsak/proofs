class User::ProfilesController < ApplicationController
  before_filter :login_required
   
  # This show action only allows users to view their own profile
  def show
    @user = current_user
  end  

  # render new.rhtml
  def new
    @user = SiteUser.new(:invitation_token => params[:invitation_token])
  end
 
  def create
    #logout_keeping_session!
    @user = SiteUser.new(:login => params[:user][:login],
										 		 :email => params[:user][:email],
										 		 :name => params[:user][:name],
										 		 :password => params[:user][:password],
										 		 :password_confirmation => params[:user][:password_confirmation],
												 :invitation_token => params[:user][:invitation_token])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_to new_gallery_path(:user_id => @user.id)
      @user.activate!
      flash[:notice] = "Cool, now you can make a gallery."
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or %s."
			flash[:error_item] = ["contact us", contact_site]
      render :action => 'new'
    end
  end

	def edit
		@user = current_user
		if !@user.identity_url.blank? && @user.crypted_password.blank?
			redirect_to edit_user_openid_account_path
		end
  end

  def update
    @user = current_user
    if @user.update_attributes(:name  => params[:user][:name],
															 :email => params[:user][:email])
      flash[:notice] = "Profile updated."
      redirect_to :action => 'show'
    else
			flash.now[:error] = "There was a problem updating your profile."
      render :action => 'edit'
    end
  end

end
