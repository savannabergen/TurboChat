class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield if block_given?
    respond_to_on_destroy
  end

  private

  def respond_to_on_destroy
    if request.headers['HTTP_ACCEPT'] =~ /json/
      head :no_content
    else
      redirect_to root_path, notice: 'Signed out!'
    end
  end
end