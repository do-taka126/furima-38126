class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index

  def index
    @order_payment = OrderPayment.new
  end
  
  def create
    @order_payment = OrderPayment.new(order_params)
    if @order_payment.valid?
      pay_item
      @order_payment.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_payment).permit(:postcode, :prefecture_id, :city, :address_line, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
    @orders = Order.all
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || Order.includes(:item).find_by(item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
