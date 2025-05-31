class AuthController < ApplicationController
  def check
    if user_signed_in?
      render json: { authenticated: true }
    else
      render json: { authenticated: false }, status: :unauthorized
    end
  end
end