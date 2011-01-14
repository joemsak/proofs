class Price < ActiveRecord::Base
	self.establish_connection(
    :adapter  => "mysql",
    :host     => "mysql.db.michaelyoungblood.net",
    :username => "michael",
    :password => "0liver!",
    :database => "new_youngblood_production"
  )
  def name_and_price
  	name + '_' + price.to_s
  end
end
