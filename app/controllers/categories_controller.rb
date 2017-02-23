class CategoriesController < ApplicationController

  def show
    @top_brands = Brand.brand_with_product
    @category = Category.find(params[:id])

    if params[:category_id].present?
      @sub = Category.find(params[:category_id])
      @products = Product.where(category_id: params[:category_id])
    elsif  @category.sub_categories.present?
      @products = Product.where(category_id: @category.sub_categories.first.id)
    else
       @products = Product.where(category_id: @category.id)
    end

    @categories = Category.all
    @sub_categories = @category.sub_categories
  end

end
