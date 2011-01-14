class Photo < ActiveRecord::Base
	belongs_to :gallery
	has_many :line_items
	
	has_attached_file :image, 
	                    :styles => { 	:large => "700x466>",
	                    							:medium => '150x150#',
                 										:thumb => '48x48#' },
	                    :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
										  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
	                                 
	  validates_attachment_presence :image
	  validates_attachment_content_type :image, 
																	  	:content_type => ['image/jpeg', 'image/jpg'] 
																	  	
	  def swfupload_file=(data)
  		data.content_type = MIME::Types.type_for(data.original_filename).to_s
  		self.image = data
		end
end
