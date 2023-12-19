class Address < ApplicationRecord
  
  belongs_to :customer


  def address_display
  '〒' + post_code.to_s + ' ' + address.to_s + ' ' + name.to_s
  end

end
