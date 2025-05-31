class SessionsController < Devise::SessionsController
  respond_to :json

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "Logged out successfully."
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource
      token = request.env['warden-jwt_auth.token']
      puts "Token: #{token}" # Log the token
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: {
          id: resource.id,
          email: resource.email,
          token: token
        }
      }, status: :ok
    else
      render json: { status: { message: "Can't authenticate user.", code: 401 } }, status: :unauthorized
  end
end