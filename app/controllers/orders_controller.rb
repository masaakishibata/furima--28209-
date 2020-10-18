class OrdersController < ApplicationController
  before_action :new_order, only: [:index, :new]
  before_action :item_find, only: [:index]


  def index
  end

  def new
  end

  def create
    binding.pry
    @order = Orders.new(order_params)
    if @order.valid?
      pay_item
      @orders.save
      redirect_to item_orders_path(@item.id)
    else
      render action: :index
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
      :phone_number)
      .marge(
      user_id: current_user.id,
      item_id: params[:item_id],
      user_items_id: params[:user_items_id],
      tokne: params[:tokne])
  end

  def pay_item
    Payjs.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjs.Charge.create(
      amount: order_params(:item_id),
      card: order_params[:tokne],
      currency: 'jpy')
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def new_order
    @order = Orders.new
  end

end
