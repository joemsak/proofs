class CreateLineItems < ActiveRecord::Migration 
def self.up 
create_table :line_items do |t| 
t.integer :photo_id, :null => false, :options => 
"CONSTRAINT fk_line_item_photos REFERENCES photos(id)" 
t.integer :order_id, :null => false, :options => 
"CONSTRAINT fk_line_item_orders REFERENCES orders(id)" 
t.integer :quantity, :null => false 
t.string :size, :null => false
t.timestamps 
end 
end 
def self.down 
drop_table :line_items 
end 
end 
