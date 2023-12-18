class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = customer_id
    @address.save
    redirect_to request.referer
  end

  def edit
  end

  private
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
