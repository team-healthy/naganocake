class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    #@order_detail.update(making_status: params[:order_detail][:making_status])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    @order_details = order.order_details.all


  #   if @order_detail.making_status == "in_making"
  #     @order.update(order_status: 2)
  #   elsif @order.order_details.count == @order.order_details.where(making_status: "completed").count
  #     @order.update(order_status: 3)
  #   end

  #   redirect_to admin_order_path(@order_detail.order)

  #   flash[:notice] = "更新に成功しました！"

  # end



  #制作ステータスの更新が成功したかどうかのフラグ
    is_updated = true
    #注文詳細の製作ステータスを更新
    if@order_detail.update(order_detail_params)
      # 製作ステータスが "製作中" の場合、注文のステータスを "製作中"に更新
      @order.update(status: "making") if @order_detail.making_status == "in_making"

      # すべての注文詳細の製作ステータスが "製作完了" であるか確認
      @order_details.each do |order_detail|
      if order_detail.making_status != "making_completed"
        is_updated = false # フラグを false に設定
      end
    end
      # すべての注文詳細の製作ステータスが "製作完了" の場合、注文のステータスを更新
    @order.update(status: "preparing_ship") if is_updated
    end
    redirect_to admin_order_path(@order_detail.order), notice: "製作ステータスを更新しました" #注文詳細が属する注文の詳細ページにリダイレクト
  end

  #   if params[:order_detail][:making_status] == "in_making"
  #     order.update(status:"making")
  #   end

  #   if is_all_order_details_making_completed(@order)
  #     order.update(status: 'preparing_ship')
  #   end

  #   flash[:notice] = "更新に成功しました。"
  #   redirect_to admin_order_path(@order_detail.order.id)
  # end



  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status, :order_id, :item_id, :price, :amount, :status)
  end

  # def is_making_completed(order)
  #   order.order_details.each do |order_detail|
  #     if order_detail.making_status != 'making_completed'
  #       return false
  #     end
  #   end
  #   return true
  # end

  # 注文ステータスを更新
  # def update_status
  #   @order = @order_detail.order  #注文詳細が属する注文する取得
  #   @order_details = @order.order_details  #注文に関連する注文詳細一覧を取得

  #   if @order_detail.making_status == "製作中"
  #     @order.update(status: "製作中") #注文ステータスを"製作中"に更新
  #   end

  #   if @order_detail.making_status == "制作完了" && @order_details.all? { |detail| detail.making_status == "制作完了" }
  #     @order.update(status: "発送準備中") #注文ステータスを"発送準備中"に更新
  #   end
  # end

  # def is_all_order_details_making_completed(order)
  #   @order.order_details.each do |order_detail|
  #     if order_detail.making_status != 'making_completed'
  #       return false
  #     end
  #   end
  #   return true
  # end



end
