class ProductsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show, :categories]
  before_action :require_admin, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 9

    products = Product.all
    products = products.where("name LIKE ?", "%#{params[:q]}%") if params[:q].present?
    products = products.where(category: params[:category]) if params[:category].present?

    total = products.count
    products = products.offset((page - 1) * per_page).limit(per_page)

    render json: { products: products, total: total, page: page, per_page: per_page }
  end

  # GET /products/:id
  def show
    render json: @product
  end

  # POST /products (per area admin futura)
  def create
    @product = Product.new(product_params)
    
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  # GET /products/categories
  def categories
    categories = Product.distinct.pluck(:category).compact
    render json: categories
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product not found' }, status: :not_found
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :image_url, :stock_quantity)
  end
end