class Api::CategoriesController < Api::ApiController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :search]

  # GET /api/profile?auth_token=
  # Get profile of user
  # Input: auth_token
  # Output: Profile of user if auth_token valid
  def show
    if @category
      products = @category.products
      list_products = []
      products.each do |v| 
        list_products << ProductSerializer.new(v).serializable_hash
      end
      render :status => 200,
             :json => { :status => true,
                        :message => "",
                        :data => {
                          :category => @category,
                          :products => list_products
                        } 
                      }
    else
      render :status => :unprocessable_entity,
             :json => { :status => false,
                        :message => "Cateogy not found" ,
                        :data => {:error_code => 120, :error_message => "Cateogy not found"} }
    end
  end

  def search
    if @category
      products = Product.where(category: @category.id)
                        .where("title like '%#{params[:title]}%'")
      list_products = []
      products.each do |v| 
        list_products << ProductSerializer.new(v).serializable_hash
      end
      render :status => 200,
             :json => { :status => true,
                        :message => "",
                        :data => {
                          :category => @category,
                          :products => list_products
                        } 
                      }

    else
      render :status => :unprocessable_entity,
             :json => { :status => false,
                        :message => "Cateogy not found" ,
                        :data => {:error_code => 120, :error_message => "Cateogy not found"} }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_profile_params
    params.require(:user_profile).permit(:name, :gender, :date_of_birth, :address, :phone_number)
  end
end