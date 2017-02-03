class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
     
    if params[:address][:billing].present?
      @address1 = Address.new(billing_params)
    end

    if params[:address][:shipping].present?
      @address2 = Address.new(shipping_params)
    end
        
    respond_to do |format|
      if @address2.save && @address1.save
        format.html { redirect_to :back, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def billing_params
      params[:address][:billing][:country] = params[:country]
      params[:address][:billing][:state] = params[:state]
      params[:address][:billing].permit(:customer_id, :address_1, :address_2, :city, :state, :country, :zipcode, :address_type, :name, :mobile_number)
    end

    def shipping_params
       # params[:address][:shipping].fetch(:addres, {})
      params[:address][:shipping][:country] = params[:address][:country]
      params[:address][:shipping][:state] = params[:address][:state]
      puts  params[:address][:shipping]
      params[:address][:shipping].permit(:customer_id, :address_1, :address_2, :city, :state, :country, :zipcode, :address_type, :name, :mobile_number)
       
    end
end
