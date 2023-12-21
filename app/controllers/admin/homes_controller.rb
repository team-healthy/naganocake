class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @order_details　= OrderDetail.all
  end
  
  
  
  
  
   def order_details_params
      params.require(:order_detail).permit(:order_id, :item_id, :tax_included_price, :amount, :making_status)
   end
  
  
end
