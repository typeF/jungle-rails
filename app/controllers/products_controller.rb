class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    @reviews = Review.all
  end

  def show
    @product = Product.find params[:id]
    @reviews = Review.all.order(created_at: :desc).where("product_id = ?", params[:id])
  end

end
