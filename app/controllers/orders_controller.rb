class OrdersController < ApplicationController
  before_action :require_buyer
  before_action :require_login
  
  def create
    product = Product.find(order_params[:product_id])
    @order = current_user.buyer.orders.new(order_params)
    @order.product = product

    if product.stock >= @order.quantity
      ActiveRecord::Base.transaction do
        @order.save!
        product.update!(stock: product.stock - @order.quantity)
      end
      redirect_to @order.product, notice: 'La commande a été créée avec succès.'
    else
      redirect_to @order.product, alert: 'Quantité demandée non disponible en stock.'
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to @order.product, alert: 'La commande n\'a pas pu être créée.'
  end
  
  private

  def order_params
    params.require(:order).permit(:quantity, :product_id)
  end

  def require_buyer
    redirect_to root_path, alert: 'Seuls les acheteurs peuvent effectuer cette action' unless current_user&.buyer
  end
end
