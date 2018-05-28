class Api::ProductsController < Api::ApiController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_product, only: [:show]

  def index
    product_favorites = Product.order("number_favorites DESC").limit(10)
    favorites = []
    product_favorites.each do |v| 
      favorites << ProductSerializer.new(v).serializable_hash
    end
    sales = []
    product_sales = Product.where('sale > ?', 0 ).order(:id).limit(10)
    product_sales.each do |v|
      sales << ProductSerializer.new(v).serializable_hash
    end
    cateogries = Category.all
    list_categories = []
    cateogries.each do |v|
      list_categories << CategoriesSerializer.new(v).serializable_hash
    end
    
    render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {
                      :product_favorites => favorites,
                      :product_sales => sales,
                      :cateogries => list_categories
                    } 
                  }
  end

  def show
    if @product
      render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {
                      :product => ProductSerializer.new(@product).serializable_hash
                    } 
                  }
    else
      render :status => 200,
            :json => { :status => false,
                  :message => "Product not found",
                  :data => {:error_code => 119, :error_message => "Not found product"}
                  }
    end
  end

  def product_favorites
    user_product_ids = current_user.user_product_favorites.pluck(:product_id)
    products = Product.where(id: user_product_ids)
    favorites = []
    products.each do |v| 
      favorites << ProductSerializer.new(v).serializable_hash
    end

    render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {
                      :products => favorites
                    } 
                  }
  end

  def favorite
    @product = Product.find(params[:product_id])
    if @product
      favorite = UserProductFavorite.where(:user_id => current_user.id, :product_id => @product.id).first
      if !favorite 
        UserProductFavorite.create(:user_id => current_user.id, :product_id => @product.id)
        @product.number_favorites += 1
        @product.save
      end
      render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {} 
                  }
    else
      render :status => 200,
            :json => { :status => false,
                  :message => "Product not found",
                  :data => {:error_code => 119, :error_message => "Not found product"}
                  }
    end
  end

  def unfavorite
    product = Product.find(params[:id])
    if product
      favorite = UserProductFavorite.where(:user_id => current_user.id, :product_id => product.id).first
      if favorite
        favorite.delete
        product.update(number_favorites: product.number_favorites - 1)
      end
      render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {} 
                  }
    else
      render :status => 200,
            :json => { :status => false,
                  :message => "Product not found",
                  :data => {:error_code => 119, :error_message => "Not found product"}
                  }
    end
  end

  def product_carts
    user_product_ids = current_user.user_carts.pluck(:product_id)
    products = Product.where(id: user_product_ids)
    favorites = []
    products.each do |v| 
      favorites << ProductSerializer.new(v).serializable_hash
    end

    render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {
                      :products => favorites
                    } 
                  }
  end

  def add_to_cart
    params[:products].each do |v, i|
      UserCart.create(:user_id => current_user.id, :product_id => v[:product_id], :price => v[:price])
    end
    render :status => 200,
            :json => { :status => true,
                  :message => "Success",
                  :data => {} 
                  }
  end 

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_profile_params
    params.require(:user_profile).permit(:name, :gender, :date_of_birth, :address, :phone_number)
  end
end