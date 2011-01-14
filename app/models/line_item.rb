class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :photo


  def self.from_cart_item(cart_item)
    li = self.new
    li.photo     = cart_item.photo
    li.quantity    = cart_item.quantity
    li.size = cart_item.size.split('_')[0]
    li.price = cart_item.price
    li
  end 

end
