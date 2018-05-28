class Api::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token#,
                     #:if => Proc.new { |c| c.request.format == 'application/json' }

  # respond_to :json
  def create
    build_resource(sign_up_params)
    
    if resource.save
      data = UsersSerializer.new(resource).serializable_hash
      sign_in resource, store: false
      render :status => 200,
             :json => { :status => true,
                        :message => "Registered",
                        :data => { :user => data,
                                   :auth_token => resource.authentication_token } }
    else
      render :status => 200,
             :json => { :status => false,
                        :message => resource.errors,
                        :data => {:error_code => 121, :error_message => "Register false"} }
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end