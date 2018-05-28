class CategoriesSerializer < ActiveModel::Serializer
  attributes :id, :title, :parent_id, :content_iamge

  def content_iamge
  	object.content_image.url(:thumb)
  end
end