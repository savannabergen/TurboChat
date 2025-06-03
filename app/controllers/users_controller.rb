class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update_avatar, :avatar]

  def index
    users = User.all
    render json: { status: { code: 200, message: 'Users retrieved successfully.' }, data: UserSerializer.new(users).serializable_hash[:data] }, status: :ok
  end

  def show
    render json: { status: { code: 200, message: 'User retrieved successfully.' }, data: UserSerializer.new(@user).serializable_hash[:data] }, status: :ok
  end

  def me
    render json: { status: { code: 200, message: 'Current user retrieved successfully.' }, data: UserSerializer.new(current_user).serializable_hash[:data] }, status: :ok
  end

  def avatar
    if @user.avatar.attached?
      redirect_to rails_blob_path(@user.avatar, disposition: 'attachment')
    else
      render json: { error: 'Avatar not found' }, status: :not_found
    end
  end

  def update_avatar
    if current_user.avatar.attach(params[:avatar])
      render json: { status: { code: 200, message: 'Avatar updated successfully.' }, data: UserSerializer.new(current_user).serializable_hash[:data] }, status: :ok
    else
      render json: { status: { code: 422, message: 'Failed to update avatar.' }, errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: { code: 404, message: 'User not found.' } }, status: :not_found
  end
end