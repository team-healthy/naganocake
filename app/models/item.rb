class Item < ApplicationRecord
  
  has_one_attached :image
  belongs_to :genre

  # 消費税の計算
  def add_tax_price
    (self.price * 1.10).round
  end
  
end
