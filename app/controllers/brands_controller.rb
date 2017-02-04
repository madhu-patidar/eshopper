class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all
  end

  # GET /brands/1
  # GET /brands/1.json
  def show 
    @top_brands = Brand.take(10)
    @brands = Brand.all
    @categories = Category.all
    @category = Category.find(params[:category_id])
    @brand = Brand.find(params[:id])
    @sub_categories = @brand.categories.where(category_id: params[:category_id]).order(:id)

    if params[:sub_category_id].present?
      @sub = Category.find(params[:sub_category_id])
      @products = Product.where(category_id: params[:sub_category_id], brand_id: params[:id])
    elsif @sub_categories.present?
        @products = Product.where(category_id: @sub_categories.first.id,brand_id: params[:id])
    # elsif 
    #   @products = Product.where(category_id: @category.sub_categories.first.id,brand_id: params[:id])
    end
   
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.fetch(:brand, {})
    end
end
