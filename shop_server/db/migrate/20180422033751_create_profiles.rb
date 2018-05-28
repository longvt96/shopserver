class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
    	t.integer :user_id
    	t.string :name
    	t.integer :gender
    	t.datetime :date_of_birth
    	t.string :phone_number
    	t.string :address

     	t.timestamps null: false
    end
  end
end
