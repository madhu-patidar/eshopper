class ProductsController < ApplicationController

  def show
    @product = Product.find(params[:id])
    @categories = Category.all
    @top_brands = Brand.brand_with_product
    @category = @product.category
  end

end
