class UserInfosController < ApplicationController
  before_action :authenticate_request

  def show
    user_info = current_user.user_info
    if user_info
      render json: user_info, include: :address
    else
      render json: { error: 'User info not found' }, status: :not_found
    end
  end

  def update
    user_info = current_user.user_info || current_user.build_user_info
    if user_info.update(user_info_params)
      render json: user_info, include: :address
    else
      render json: { error: user_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_info_params
    params.require(:user_info).permit(
      :last_name, :first_name, :phone,
      address_attributes: [:street, :number, :city, :zip, :province]
    )
  end
end
