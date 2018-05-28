class AddAttachmentContentImageToProductImages < ActiveRecord::Migration
  def self.up
    change_table :product_images do |t|
      t.attachment :content_image
    end
  end

  def self.down
    remove_attachment :product_images, :content_image
  end
end
