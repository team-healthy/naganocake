class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @orders = Order.all
  end
  
  
   def order_params
      params.require(:order).permit(:post_code, :adress, :name, :shipping_cost, :total_payment, :payment_method, :status)
   end
  
  
end
