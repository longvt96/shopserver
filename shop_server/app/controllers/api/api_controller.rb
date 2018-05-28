class Api::ApiController < ApplicationController
  before_filter :authenticate_user_from_token!
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    render :status => 200,
           :json => { :success => true,
                      :info => "test",
                      :data => {} }
  end

end