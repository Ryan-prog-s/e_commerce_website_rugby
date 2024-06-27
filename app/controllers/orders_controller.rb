class OrdersController < ApplicationController
    before_action :require_buyer
    before_action :require_login
  
    def create
      @order = current_user.buyer.orders.new(order_params)
      @order.product = Product.find(params[:product_id])
      if @order.save
        redirect_to @order.product, notice: 'La commande a été créée avec succès.'
      else
        redirect_to @order.product, alert: 'La commande n\'a pas pu être créée.'
      end
    end
  
    private
  
    def order_params
      params.require(:order).permit(:quantity)
    end
  
    def require_buyer
      redirect_to root_path, alert: 'Seuls les acheteurs peuvent effectuer cette action' unless current_user&.buyer
    end
end
