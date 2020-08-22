class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create
    # POST /auth//signup
  # return authenticated token upon signup
  def create
    if User.find_by(email: params[:email])
        response = { message: Message.account_already_exists }
        return json_response(response, :bad_request) 
    end
    user = User.create!(user_params)
    user[:password_digest] = ""
    # auth_token = AuthenticateUser.new(user.email, user.password).call            
    # response = { message: Message.account_created, auth_token: auth_token}
    response = { message: Message.account_created, user_details: user }
    return json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
