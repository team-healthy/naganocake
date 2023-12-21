class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

  enum is_active: {販売中:0, 販売停止中:1}

  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end
