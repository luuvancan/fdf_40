class OrderMailerPreview < ActionMailer::Preview
  def result_order
    user = User.first
    OrderMailer.result_order(user)
  end
end
