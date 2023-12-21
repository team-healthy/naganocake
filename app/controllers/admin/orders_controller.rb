class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
    # tax = 1.1
    # @total_payment_with_tax = (@order.total_payment - @shipping_cost) * tax
    # @total_payment_with_tax = @order.total_payment.with_tax_price
    @customer = @order.customer
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order_details.update_all(status: "wait_production") if @order.status == "confirm_payment"
    end
    redirect_to admin_order_path(@order.id)
    # if @order.update(order_params)
    #   @order_details.update_all(making_status: "production_pending") if @order.order_status == "payment_confirmation"
    #   redirect_to admin_order_path(@order.id)
    # else
    #   render :show
    # end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_cost, :payment_method, :total_payment, :status, :name, :post_code, :address)
  end
end