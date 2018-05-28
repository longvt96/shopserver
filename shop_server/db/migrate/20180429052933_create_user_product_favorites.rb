class CreateUserProductFavorites < ActiveRecord::Migration
  def change
    create_table :user_product_favorites do |t|

    	t.integer :user_id
    	t.integer :product_id
      t.timestamps null: false
    end
  end
end
