class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :signup]

  # POST /auth/login
  def login
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { 
        token: token,
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          role: user.role
        }
      }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # POST /auth/signup
  def signup
    user = User.new(user_params)
    
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { 
        token: token,
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          role: user.role
        }
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /auth/me
  def me
    render json: {
      id: @current_user.id,
      email: @current_user.email,
      name: @current_user.name,
      role: @current_user.role
    }
  end

  # POST /auth/logout
  def logout
    # Con JWT stateless, il logout è gestito lato client
    # Qui possiamo solo confermare
    render json: { message: 'Logged out successfully' }, status: :ok
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
