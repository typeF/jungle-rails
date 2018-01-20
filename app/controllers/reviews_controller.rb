class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to product_path(@review.product_id)
    else
      redirect_to :back
    end
  end

  def destroy
    @review = Review.find params[:id]
    product_id = @review.product_id
    @review.destroy
    redirect_to product_path(product_id)
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating,
      :product_id,
      :user_id
    )
  end

end
