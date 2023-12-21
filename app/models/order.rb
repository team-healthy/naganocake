class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  validates :payment_method, presence: true

# 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

 def add_sub_total
    (item.price * 1.10).floor * amount
  end

  #支払い方法
  enum payment_method: { credit_card: 0, transfer: 1 }

  #注文ステータス
  enum status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}
end
