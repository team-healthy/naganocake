class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
  end

  def edit
  end
end
