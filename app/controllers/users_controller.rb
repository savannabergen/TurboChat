class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    users = User.all
    render json: { status: { code: 200, message: 'Users retrieved successfully.' }, data: UserSerializer.new(users).serializable_hash[:data] }, status: :ok
  end

  def show
    render json: { status: { code: 200, message: 'User retrieved successfully.' }, data: UserSerializer.new(@user).serializable_hash[:data] }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: { code: 404, message: 'User not found.' } }, status: :not_found
  end
end