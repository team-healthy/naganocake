class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  # before_action :cart_item_item?, only: [:create]

  def index
  	@cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
  	@cart_item = CartItem.new(cart_item_params)
  	#カートにすでに商品が入っていた場合
  	if @cart_item_exist = CartItem.find_by(item_id: @cart_item.item_id, customer_id: current_customer)
  	  @cart_item_exist.amount = @cart_item_exist.amount.to_i + @cart_item.amount.to_i
  	  @cart_item_exist.update(amount: @cart_item_exist.amount)
    else
    	# カートに何も入っていない場合
    	@cart_item.customer_id = current_customer.id
    	@cart_item.save
  	end
  	redirect_to cart_items_path
  end

  def update
  	cart_item_exist = CartItem.find(params[:id])
  	cart_item_exist.update(cart_item_params)
  	redirect_to request.referer
  end

  def destroy
  	cart_item = CartItem.find(params[:id])
  	cart_item.destroy
  	redirect_to request.referer
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to request.referer
  end

  private

 # def cart_item_item?
	# 	redirect_to item_path(params[:cart_item, :item_id]), notice: "個数を入力してください。" if params[:cart_item, :amount].empty?
	# end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end

