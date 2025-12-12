class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    
    if token
      decoded = JsonWebToken.decode(token)
      if decoded
        @current_user = User.find_by(id: decoded[:user_id])
        return if @current_user
      end
    end
    
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def current_user
    @current_user
  end

  def require_admin
    unless current_user&.role == 'admin'
      render json: { error: 'Admin access required' }, status: :forbidden
    end
  end
end
