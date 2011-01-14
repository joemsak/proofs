class AddAttachmentsImageToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :image_file_name, :string
    add_column :photos, :image_content_type, :string
    add_column :photos, :image_file_size, :integer
  end

  def self.down
    remove_column :photos, :image_file_name
    remove_column :photos, :image_content_type
    remove_column :photos, :image_file_size
  end
end
