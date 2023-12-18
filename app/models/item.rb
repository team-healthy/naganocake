class Item < ApplicationRecord
  # 以下2行追加しました
  has_one_attached :image
  belongs_to :genre

end
