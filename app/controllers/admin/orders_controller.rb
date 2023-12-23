class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
    #@customer = @order.customer
    # @order_details = @order.order_details
    # @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details

  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order_details.update_all(making_status: "waiting_for_making" ) if @order.status == "confirm_payment"
       redirect_to admin_order_path(@order.id)
    else
      render :show
    end
  end
  #   end
  #   redirect_to admin_order_path(@order.id)
  # end

  # #注文ステータスの更新
  # def update
  #   @order = Order.find(params[:id]) #特定の注文を取得
  #   @order_details = @order.order_details #注文に関連する注文詳細を取得
  #   @order.update(order_params)
  #   if @order.status == "confirm_payment"
  #     @order_details.update_all(making_status: "waiting_for_making")# 注文ステータスが 入金確認に更新すると製作ステータスが全て更新
  #   end
  #   redirect_to admin_order_path(@order), notice: "注文ステータスを変更しました" #フラッシュメッセージ
  # end


  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_cost, :payment_method, :total_payment, :status, :name, :post_code, :address)
  end
end