class Api::ProfilesController < Api::ApiController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :set_user_profile, only: [:show, :update]

  # GET /api/profile?auth_token=
  # Get profile of user
  # Input: auth_token
  # Output: Profile of user if auth_token valid
  def show
    if @user_profile
    
      render :status => 200,
             :json => { :status => true,
                        :message => "",
                        :data => { 
                          :profile => @user_profile
                        } 
                      }
    else
      render :status => :unprocessable_entity,
             :json => { :status => false,
                        :message => "not created yet" ,
                        :data => {:error_code => 115, :error_message => "Not found profile"} }
    end
  end

  def create
    # only 1 profile per user
    if current_user.profile
      return render :status => 200,
                    :json => { :status => false,
                               :message => current_user.errors,
                               :data => {:error_code => 116, :error_message => "Profile exist"} }
    end
    @user_profile = current_user.build_profile(user_profile_params)

    if @user_profile.save
      render :status => 200,
             :json => { :status => true,
                        :message => "Profile Created",
                        :data => {
                            :profile => @user_profile
                          } }
    else
      render :status => 200,
             :json => { :status => false,
                        :message => "Create profile error",
                        :data => {:error_code => 117, :error_message =>"Phone number invalid" } }
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @user_profile = current_user.profile
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_profile_params
    params.require(:user_profile).permit(:name, :gender, :date_of_birth, :address, :phone_number)
  end
end