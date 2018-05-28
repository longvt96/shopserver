class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :title
    	t.text :description
    	t.integer :number_favorites
    	t.integer :sale, :default => 0
    	t.integer :price
    	t.integer :category_id
    	t.integer :shop_id
    	
  		t.timestamps null: false
    end
  end
end
