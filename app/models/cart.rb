class Cart
	attr_reader :items 
	def initialize 
		@items = [] 
	end 
	
	def add_photo(photo, qty, size)
		current_item = @items.find {|item| item.photo == photo && item.size == size } 
		if current_item 
			current_item.increment_quantity(qty) 
		else 
			@items << CartItem.new(photo, qty, size)
		end
	end
 
	
	def total_price 
		@items.sum { |item| item.quantity.to_i*item.size.split('_')[1].to_i } 
	end 
	
	def total_items 
		@items.sum { |item| item.quantity } 
	end 
	
	def remove_photo(photo_id, size)
		photo = Photo.find(photo_id)
	  current_item = @items.find {|item| item.photo == photo && item.size == size}
	  current_item.decrement_quantity
	  if current_item.quantity == 0
	    @items.delete(current_item)
	  end
  	current_item
	end

end 
