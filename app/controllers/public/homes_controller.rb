class Public::HomesController < ApplicationController
  def top
    @new_items = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end


private


def item_params
  params.require(:item).permit(:name, :non_taxed_price)
end