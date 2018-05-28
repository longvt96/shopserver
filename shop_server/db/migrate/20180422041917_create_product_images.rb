class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
		t.integer :product_id
		t.integer :is_thumb, :default => 0
		
      	t.timestamps null: false
    end
  end
end
