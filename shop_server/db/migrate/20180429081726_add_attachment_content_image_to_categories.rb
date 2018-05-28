class AddAttachmentContentImageToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :content_image
    end
  end

  def self.down
    remove_attachment :categories, :content_image
  end
end
