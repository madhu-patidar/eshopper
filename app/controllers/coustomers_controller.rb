class CoustomersController < ApplicationController
  before_action :set_coustomer, only: [:show, :edit, :update, :destroy]

  # GET /coustomers
  # GET /coustomers.json
  def index
    @coustomers = Coustomer.all
  end

  # GET /coustomers/1
  # GET /coustomers/1.json
  def show
  end

  # GET /coustomers/new
  def new
    @coustomer = Coustomer.new
  end

  # GET /coustomers/1/edit
  def edit
  end

  # POST /coustomers
  # POST /coustomers.json
  def create
    @coustomer = Coustomer.new(coustomer_params)
    respond_to do |format|
      if @coustomer.save
        format.html { redirect_to @coustomer, notice: 'Coustomer was successfully created.' }
        format.json { render :show, status: :created, location: @coustomer }
      else
        format.html { render :new }
        format.json { render json: @coustomer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coustomers/1
  # PATCH/PUT /coustomers/1.json
  def update
    respond_to do |format|
      if @coustomer.update(coustomer_params)
        format.html { redirect_to @coustomer, notice: 'Coustomer was successfully updated.' }
        format.json { render :show, status: :ok, location: @coustomer }
      else
        format.html { render :edit }
        format.json { render json: @coustomer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coustomers/1
  # DELETE /coustomers/1.json
  def destroy
    @coustomer.destroy
    respond_to do |format|
      format.html { redirect_to coustomers_url, notice: 'Coustomer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coustomer
      @coustomer = Coustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coustomer_params
      params.require(:customer).permit(:email,:first_name,:last_name, :admin)
    end
end
