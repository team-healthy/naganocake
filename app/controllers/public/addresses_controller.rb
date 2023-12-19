class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!


  def index
    # current_customerがnilでないことを確認する
    if current_customer
      @addresses = current_customer.addresses
      @address = Address.new
    else
      # ユーザーがnilの場合に適切な処理を行う（ログインページへリダイレクトなど）
      redirect_to new_customer_session_path, alert: 'ログインしてください'
    end
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to request.referer
  end

  def edit
    @address = Address.find(params[:id])

  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path(@address)

  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer
  end

  private
  def address_params
     params.require(:address).permit(:post_code, :address, :name, :customer_id)

  end
end


