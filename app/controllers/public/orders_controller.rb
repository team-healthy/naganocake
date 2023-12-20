class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

# 注文情報入力画面
  def new
    @order = Order.new
  end

   def confirm
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @shipping_cost = 800 #送料は800円で固定
      @selected_payment_method = params[:order][:payment_method]
      #以下、商品合計額の計算
      ary = []
      @cart_items.each do |cart_item|
        ary << cart_item.item.price*cart_item.quantity
      end
      @cart_items_price = ary.sum

      @total_price = @shipping_cost + @cart_items_price
      @address_type = params[:order][:address_type]
        case @address_type
        when "member_address"
        @selected_address = current_customer.post_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name

        when "registered_address"
        unless params[:order][:registered_address_id] == ""
          selected = Address.find(params[:order][:registered_address_id])
          @selected_address = selected.post_code + " " + selected.address + " " + selected.name
  	    else
  	   render :confirm
  	    end

        when "new_address"
        unless params[:order][:new_post_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
  	      @selected_address = params[:order][:new_post_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
  	    else
  	  render :confirm
  	    end
     end
    end


    def create
      @order = Order.new
      @order.customer_id = current_customer.id
      @order.shipping_cost = 800
      @cart_items = CartItem.where(customer_id: current_customer.id)
      ary = []
      @cart_items.each do |cart_item|
        ary << cart_item.item.price*cart_item.quantity
      end
      @cart_items_price = ary.sum
      @order.total_payment = @order.shipping_cost + @cart_items_price
      @order.payment_method = params[:order][:payment_method]
      if @order.payment_method == "credit_card"
        @order.status = 1
      else
        @order.status = 0
      end

      address_type = params[:order][:address_type]
      case address_type
    when "member_address"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @selected_address = "#{@order.post_code} #{@order.address}"
    when "registered_address"
      Address.find(params[:order][:registered_address_id])
      selected = Address.find(params[:order][:registered_address_id])
      @order.post_code = selected.post_code
      @order.address = selected.address
      @order.name = selected.name
      @selected_address = "#{@order.post_code} #{@order.address}"
    when "new_address"
      @order.post_code = params[:order][:new_post_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]
      @selected_address = "#{@order.post_code} #{@order.address}"
    end

    if @order.save
      if @order.status == 0
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, quantity: cart_item.quantity, making_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, quantity: cart_item.quantity, making_status: 1)
        end
      end
      @cart_items.destroy_all
      redirect_to orders_complete_path
    else
      flash.now[:alert] = "注文に失敗しました。必要な情報を入力してください。"
      render :confirm
    end
  end


    def index
      @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
    end

    def show
      @order = Order.find(params[:id])
      @order_details= OrderDetail.where(order_id: @order.id)
    end

    def complete
    end

    private
    def order_params
      params.require(:order).permit(:payment_method, :post_code, :address, :name)
    end

end
