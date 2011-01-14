class PaymentsController < ApplicationController
	include ActiveMerchant::Billing
	
  def index
  end

 def confirm
  redirect_to :action => 'index' unless params[:token]
  
  details_response = gateway.details_for(params[:token])
  
  @cart = find_cart
  
  if !details_response.success?
    @message = details_response.message
    render :action => 'error'
    return
  end
    
  @address = details_response.address
end

def new
	@cart = find_cart
	@contact = Contact.new
	@user = current_user
end

def manual_complete
	@cart = find_cart
	@user = User.find(current_user.id)
	@order = @user.orders.new
  @order.add_line_items_from_cart(@cart)
  @contact = @order.build_contact(params[:contact])  
   if @order.save && @contact.save
   	session[:cart] = nil
   	flash[:notice] = 'Order Complete! Michael will contact you shortly to make payment arrangements.'
   	OrderMailer.deliver_customer_email(@order)
   	OrderMailer.deliver_admin_email(@order)
   	redirect_to order_path(@order)
   else
   	render :action => 'new'
   end
end

  def complete
  	@user = User.find(current_user.id)
	  @cart = find_cart
	  purchase = gateway.purchase(@cart.total_price*100,
	    :ip       => request.remote_ip,
	    :payer_id => params[:payer_id],
	    :token    => params[:token]
	  )
	  @order = @user.orders.new 
    @order.add_line_items_from_cart(@cart) 
    if @order.save                     
      session[:cart] = nil
      OrderMailer.deliver_customer_email(@order)
   		OrderMailer.deliver_admin_email(@order)
    else
      render :action => 'confirm'
    end
	  if !purchase.success?
	    @message = purchase.message
	    render :action => 'error'
	    return
	  end
	end
  
	def checkout
		@cart = find_cart
	  setup_response = gateway.setup_purchase(@cart.total_price*100,
	    :ip                => request.remote_ip,
	    :return_url        => url_for(:action => 'confirm', :only_path => false),
	    :cancel_return_url => url_for(:action => 'index', :only_path => false)
	  )
	  redirect_to gateway.redirect_url_for(setup_response.token)
	end
	
	private
		
		def gateway
		  @gateway ||= PaypalExpressGateway.new(
		    :login => APP_CONFIG['settings']['paypal_login'],
		    :password => APP_CONFIG['settings']['paypal_password'],
		    :signature => APP_CONFIG['settings']['paypal_signature']
		  )
		end
				
		def find_cart 
			session[:cart] ||= Cart.new 
		end 

end
