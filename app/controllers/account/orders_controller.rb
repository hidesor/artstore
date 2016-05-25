class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    #@orders = current_user.orders
    @orders = current_user.orders.order("id DESC")
  end



  def pay_with_credit_card
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("credit_card")
    @order.pay!

    redirect_to order_path(@order.token), notice: "成功完成付款"
   end

   def order_params
     params.require(:order).permit(info_attributes: [:billing_name,
                                                     :billing_address,
                                                     :shipping_name,
                                                     :shipping_address] )
   end
end
