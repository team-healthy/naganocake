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

  #注文ステータス {0: 入金待ち, 1: 入金確認, 2: 製作中 , 3: 発送準備中 , 4: 発送済み}
  enum status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}
end
