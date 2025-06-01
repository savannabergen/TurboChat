require_relative '../../lib/json_web_token'

class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = request.headers['Authorization'].to_s.split(' ').last
    decoded_token = JsonWebToken.decode(token)
    @current_user = User.find(decoded_token['user_id']) if decoded_token
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
end
