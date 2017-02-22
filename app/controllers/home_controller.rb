class HomeController < ApplicationController
  
  def index
    @banners = Banner.where(status: true)
    @top_brands = Brand.brand_with_product
    @categories = Category.all
    @category = Category.last
    
    if params[:sub_category_id].present?
      @sub = Category.find(params[:sub_category_id])
      @products = Product.where(category_id: params[:sub_category_id])
    elsif Category.first.present? && Category.first.sub_categories.present?
      @products = Product.where(category_id:  Category.first.sub_categories.first.id)
    end

  end
end
