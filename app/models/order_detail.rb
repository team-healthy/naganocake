class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  def add_sub_total
    (item.price * 1.10).floor * amount
  end
  #製作ステータス
  enum making_status: { making_unable: 0, waiting_for_making: 1, in_making: 2, making_completed: 3 }
end
