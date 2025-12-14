class CartItemsController < ApplicationController
  before_action :set_cart

  # POST /cart/items
  def create
    product = Product.find(params[:product_id])
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = 0 if item.new_record?
    item.quantity += params[:quantity].to_i
    item.unit_price = product.price

    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /cart/items/:id
  def update
    item = @cart.cart_items.find(params[:id])
    if item.update(quantity: params[:quantity])
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /cart/items/:id
  def destroy
    item = @cart.cart_items.find(params[:id])
    item.destroy
    head :no_content
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart!
  end
end
