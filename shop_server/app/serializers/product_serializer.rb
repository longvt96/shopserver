class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :description, :sale, :number_favorites, :product_iamges, :category_id, :shop_id, :shop_info

  has_many :product_iamges

  def product_iamges
  	list_images = []
  	images = ProductImage.where(:product_id => object.id)
  	if images
	  	images.each do |v|
	  		list_images << v.content_image.url(:medium)
	  	end
  	end
  	list_images
  end

  def shop_info
    object.shop
  end
end