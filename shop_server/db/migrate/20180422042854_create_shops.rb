class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
    	t.string :title
    	t.string :address
    	t.string :phone_nunber
    	t.string :description
    	
      t.timestamps null: false
    end
  end
end
