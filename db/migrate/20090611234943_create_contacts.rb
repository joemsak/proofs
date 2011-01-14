class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :email
      t.string :phone_number
      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
