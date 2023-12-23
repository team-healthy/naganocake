class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :addresses
         has_many :cart_items, dependent: :destroy


  def active_for_authentication?
    super && (self.is_active == true)
  end


  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("first_name LIKE? OR last_name LIKE?", "%#{word}%", "%#{word}%")
    elsif search == "forward_match"
      @customer = Customer.where("first_name LIKE? OR last_name LIKE?", "%#{word}%", "%#{word}%")

    elsif search == "backward_match"
      @customer = Customer.where("first_name LIKE? OR last_name LIKE?", "%#{word}%", "%#{word}%")

    elsif search == "partial_match"
     @customer = Customer.where("first_name LIKE? OR last_name LIKE?", "%#{word}%", "%#{word}%")

    else
      @customer = Customer.all
    end
  end








end
