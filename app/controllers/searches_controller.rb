class SerchesController < ApplicationController
    
    
    def search
        @range = params[:range]
        @word = params[:word]
    
        if @range == "Customer"
          @customer = Customer.looks(params[:search], params[:word])
        else
           @item = Item.looks(params[:search], params[:word])
        end
    end 
    
    
    
    
  
    
end
