class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    token = JsonWebToken.encode(user_id: resource.id)
    render json: { token: token }
  end
end