class OrdersController < ApplicationController
  require 'payjp'
  before_action :new_order, only: [:index, :new]
  before_action :item_find, only: [:index, :create, :pay_item]


  def index
  end

  def new
  end

  def create
    @order = Orders.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:orders).permit(
      :prefectures_id,
      :municipality,
      :building_number,
      :house_number,
      :postal_code,
      :phone_number,
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token],
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item[:price],
      card: order_params[:token],
      currency: 'jpy',
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def new_order
    @order = Orders.new
  end

end
