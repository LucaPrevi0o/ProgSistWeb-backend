class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    
    # Filtro per categoria
    @products = @products.by_category(params[:category]) if params[:category].present?
    
    # Ricerca testuale
    @products = @products.search(params[:q]) if params[:q].present?
    
    # Paginazione (opzionale)
    if params[:page].present?
      per_page = params[:per_page] || 10
      @products = @products.page(params[:page]).per(per_page)
    end
    
    render json: @products
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