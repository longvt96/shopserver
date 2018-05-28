class Api::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token#,
                     # :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :verify_signed_out_user
  before_filter :authenticate_user_from_token!, only: [:destroy]

  # Api login
  # Input: user_params, headers(country)
  # Output: Login success if account and country true, errors if false
  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.authentication_token = generate_authentication_token
    current_user.save(:validate => false)
    
    # avatar = current_user.profile.avatar.url
      render :status => 200,
             :json => { :status => true,
                        :message => "Logged in",
                        :data => { :auth_token => current_user.authentication_token,
                                   :email => current_user.email,
                                   # :avatar => avatar
                        } }

  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update(authentication_token: nil)
    sign_out current_user
    render :status => 200,
           :json => { :status => true,
                      :message => "Logged out",
                      :data => {} }
  end

  def failure
    render :status => 200,
           :json => { :status => false,
                      :message => "Login Failed",
                      :data => {:error_code => 132, :error_message => "Login Failed"} }
  end
  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end