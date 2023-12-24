class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
    @quantity = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
