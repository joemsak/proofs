class CartItem 
	attr_reader :photo, :quantity, :size, :price

	def initialize(photo, qty, size) 
		@photo = photo 
		@quantity = qty
		@size = size
		@price = qty.to_i*size.split('_')[1].to_i
	end 
	
	def increment_quantity(qty) 
		@quantity += qty
	end 
	
	def decrement_quantity
  	@quantity -= 1 if @quantity > 0
	end
 
end 
