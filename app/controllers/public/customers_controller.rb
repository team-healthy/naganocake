class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
     @customer = current_customer
  end

  def edit
     @customer = Customer.find(params[:id])
  end
  
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "編集に成功しました！"
    else
      render :edit_customer_path
    end
  end 
  
  
   private
  
   def customer_params
      params.require(:customer).permit(:name, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number)
   end
  
end
