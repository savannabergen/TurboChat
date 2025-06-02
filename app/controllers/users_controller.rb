class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    users = User.all
    render json: {
      status: { code: 200, message: 'Users retrieved successfully.' },
      data: UserSerializer.new(users).serializable_hash[:data]
    }, status: :ok
  end

  def show
    render json: {
      status: { code: 200, message: 'User retrieved successfully.' },
      data: UserSerializer.new(@user).serializable_hash[:data]
    }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: { status: { code: 404, message: 'User not found.' } }, status: :not_found
  end

  def respond_with(current_user, _opts = {})
  token = request.env['warden-jwt_auth.token']
  render json: {
    status: { code: 200, message: 'Logged in successfully.' },
    data: {
      user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
      token: token
    }
  }, status: :ok
  end
end