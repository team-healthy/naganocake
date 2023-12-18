class Genre < ApplicationRecord

  # has_many追加しました
  has_many :items, dependent: :destroy

end
