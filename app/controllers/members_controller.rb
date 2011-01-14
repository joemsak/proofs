class MembersController < ApplicationController
	
	before_filter :login_required

  def index
		@users = User.member_list(params[:page])
	end

	def show
		@user = User.find_by_login(params[:id])
		if current_user.id != @user.id && !current_user.has_role?('admin')
			flash[:error] = 'You do not have access to that page.'
    	redirect_to member_path(current_user)
    end
	end

end
