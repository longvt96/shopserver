class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :user_id
    	t.integer :product_id
    	t.text :content
    	t.integer :status, :default => 0
      t.timestamps null: false
    end
  end
end
