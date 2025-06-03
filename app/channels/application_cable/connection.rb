module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.headers['Authorization']&.split(' ')&.last
      if token.present?
        decoded_token = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!, true, { algorithm: 'HS256' })
        user_id = decoded_token[0]['sub']
        User.find_by(id: user_id)
      else
        reject_unauthorized_connection
      end
    rescue JWT::VerificationError, JWT::DecodeError
      reject_unauthorized_connection
    end
  end
end