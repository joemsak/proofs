class OrderMailer < ActionMailer::Base
  
  def admin_email(order)
  	setup_admin_email(order)
  	@subject = 'Proofs Order Received.'
  	@url = order_url(order)
  	@name = @order.user.name unless order.contact
  	@name = @order.contact.name if order.contact
  end
  
  def customer_email(order)
  	setup_email(order)
  	@subject = 'Your order details for Michael Youngblood Photography'
  	@url = order_url(order)
  	@name = @order.user.name unless order.contact
  	@name = @order.contact.name if order.contact
  end

  protected
    def setup_admin_email(order)
      @recipients  = "info@michaelyoungblood.com"
      @from        = APP_CONFIG['mail']['sender']
      @sent_on     = Time.now
      @order = order
      content_type "text/html"
    end
    
    def setup_email(order)
      @recipients  = order.user.email unless order.contact
      @recipients = order.contact.email if order.contact
      @from        = APP_CONFIG['mail']['sender']
      @sent_on     = Time.now
      @order = order
      content_type "text/html"
    end
end
