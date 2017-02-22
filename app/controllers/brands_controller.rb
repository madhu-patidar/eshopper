class BrandsController < ApplicationController
  before_action :set_brand, only: [:show]

  # GET /brands
  # GET /brands.json
  def index
    @top_brands = Brand.all
    @brands = Brand.all
    @categories = Category.all
    @category = Category.first
    @brand = Brand.find(params[:id])
    @sub_categories = @brand.categories
    @products = @brand.products
  end

  def show
    @top_brands = Brand.take(10)
    @brands = Brand.all
    @categories = Category.all
    @category = Category.find(params[:category_id])
    @sub_categories = @brand.categories.where(category_id: params[:category_id]).order(:id)
    if params.has_key?(:sub_category_id)
      @sub1 = Category.find(params[:sub_category_id])
    end

    if params[:sub_category_id].present?
      @sub = Category.find(params[:sub_category_id])
      @products = Product.where(category_id: params[:sub_category_id], brand_id: params[:id])

    elsif @sub_categories.present?
        @products = Product.where(category_id: @sub_categories.first.id,brand_id: params[:id])
    else
      @products = Product.where(category_id: @category.sub_categories.first.id,brand_id: params[:id])
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
