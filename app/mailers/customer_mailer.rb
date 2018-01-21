class CustomerMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def receipt_email(order)
    @line = LineItem.includes(:product).where(order_id: order.id)
    @order = order
    @email = order.email
    mail(to: @email, subject: "Your order receipt from jungle - Order #{@order.id}")
  end
end