class HomeController < ApplicationController
  
  def index
    @banners = Banner.all
    @top_brands = Brand.take(10)
    @categories = Category.all
    @brands = Brand.all
    @category = Category.first
    
    if @category.present?
      @category = @category.sub_categories.first
    end
    
    if params[:sub_category_id].present?
      @sub = Category.find(params[:sub_category_id])
      @products = Product.where(category_id: params[:sub_category_id])
    elsif @category.present?
      @products = Product.where(category_id: @category.id)
    end

  end
end
