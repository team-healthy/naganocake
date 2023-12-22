class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  def add_sub_total
    (item.price * 1.10).floor * amount
  end
  #製作ステータス{0:製作不可,1:製作待ち,2:製作中,3:製作完了}
  enum making_status: { making_unable: 0, waiting_for_making: 1, in_making: 2, making_completed: 3 }
end
