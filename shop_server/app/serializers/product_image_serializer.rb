class ProductIamgeSerializer < ActiveModel::Serializer
  attributes :id, :content_image, :product_id

  belongs_to :product
end