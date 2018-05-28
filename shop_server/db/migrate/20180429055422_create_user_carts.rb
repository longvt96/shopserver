class CreateUserCarts < ActiveRecord::Migration
  def change
    create_table :user_carts do |t|
    	t.integer :user_id
    	t.integer :product_id
    	t.integer :price
    	
      t.timestamps null: false
    end
  end
end
