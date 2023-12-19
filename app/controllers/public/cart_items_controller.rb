class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @item = Item.find(params[:item_id])
    @cart_items = CartItem.all(@item)
  end

  def create
    @items = Item.all

  end

  def update
  end

  def destroy
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
