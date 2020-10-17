class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @orders.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :prefectures_id,
      :municipality,
      :building_number,
      :house_number,
      :postal_code,
      :phone_number,
    ).marge(
      :user_id,
      :item_id,
      :user_items_id,
      current_user.id,
      tokne: params[:tokne]
    )
  end

  def pay_item
    Payjs.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjs.Charge.create(
      amount: order_params(:item_id[:@item.price])
      card: order_params[:tokne]
      currency: 'jpy'
    )
  end
end
