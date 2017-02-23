class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]
  
  def edit
  end

  def create
    @address = Address.new(address_params) 
    respond_to do |format|
      if @address.save
        format.html { redirect_to :back, notice: 'Address was successfully created.' }
      else
        format.html { render :back }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to  checkouts_path }
        format.js
      else
        format.html { render :back }
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @address.update(status: "inactive")
        format.html { redirect_to  checkouts_path }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  private

    def set_address
      @address = Address.find(params[:id])
    end
  
    def address_params  
      params[:address].permit(:customer_id, :address_1, :address_2, :city, :state, :country, :zipcode, :address_type, :name, :mobile_number)  
    end
    
end
