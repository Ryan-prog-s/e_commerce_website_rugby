class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :require_seller, only: %i[new create edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def create
    @product = current_user.seller.products.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Le produit a été créé avec succès.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Le produit a été mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Le produit a été supprimé avec succès.'
  end

  private
    # Utilisez des rappels pour partager des configurations ou des contraintes communes entre les actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Autorisez uniquement une liste de paramètres de confiance.
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock)
    end
  
    def require_seller
      redirect_to root_path, alert: 'Seuls les vendeurs peuvent effectuer cette action' unless current_user&.seller
    end

end
