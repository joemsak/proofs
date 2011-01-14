class OrdersController < ApplicationController
  before_filter :login_required

	def index
		@orders = Order.all
	end
  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    @total_price = @order.line_items.sum("quantity*price")
		if current_user.id != @order.user_id && !current_user.has_role?('admin')
			flash[:error] = 'You do not have access to that page.'
    	redirect_to member_path(current_user)
    else
	    respond_to do |format|
	      format.html # show.html.erb
	      format.xml  { render :xml => @order }
	    end
    end
  end

end
