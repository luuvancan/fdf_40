class OrderMailer < ApplicationMailer
  def result_order user, order, order_details
    @user = user
    @order = order
    @order_details = order_details
    mail to: user.email, subject: "Your order"
  end
end
