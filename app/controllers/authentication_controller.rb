class AuthenticationController < ApplicationController  
  skip_before_action :authorize_request, only: :authenticate
    # return auth token once user is authenticated
  def authenticate
    auth = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call    
    auth[:user_details][:password_digest] = ""
    response = { message: Message.user_logged_in, loggin_details: auth }    
    json_response(response, :ok)
    # json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
