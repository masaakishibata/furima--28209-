class OrdersController < ApplicationController

  def index
  end

  def new
    @orders = Order.new
  end

  def create
    @orders = Order.new(order_params)
    if @orders.valid?
      @orders.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private

  def order_params
    params.require(:@orders).permit(
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
      current_user.id
    )
  end
end
