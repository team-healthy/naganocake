class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path, notice: "編集に成功しました！"
    else
      @customer = Customer.find(params[:id])
      render :edit_admin_customer_path
    end
  end 
  
  
  
   private
  
   def customer_params
      params.require(:customer).permit(:name, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :is_active)
   end
  
  
  
  
  
end
