class SessionsController < Devise::SessionsController
  respond_to :json

  # POST /resource/sign_in
  def create
    super do |resource|
      return respond_with({ user: resource, jwt_token: current_token })
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :ok
  end
end
