class Contact < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :address
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :zipcode
# 	validates_presence_of :email
	validates_presence_of :phone_number
	
	belongs_to :order
	belongs_to :user
	
end
