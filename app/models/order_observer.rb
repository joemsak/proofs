class OrderObserver < ActiveRecord::Observer
 
  def after_save(order) 
    OrderMailer.deliver_customer_email(order) 
    OrderMailer.deliver_admin_email(order) 
  end

end