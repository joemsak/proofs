class RootController < ApplicationController

  def index
		redirect_to member_path(current_user) if logged_in?
  end

end
