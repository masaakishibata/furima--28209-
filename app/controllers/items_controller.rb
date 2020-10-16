class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :item_find, only: [:create, :show, :edit, :update, :destroy, :ensure_current_user]
  before_action :ensure_current_user, only: [:edit]
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if @item.destroy(item_params)
      redirect_to root_path
    else
      render :show
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  
  private
  
  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :price,
      :status_id,
      :category_id,
      :delivery_charge_id,
      :shipment_source_id,
      :transport_days_id,
    ).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def ensure_current_user
    if user_signed_in? && @item.user_id != current_user.id
      redirect_to action: :show
    end
  end

  def item_find
    @item = Item.find(params[:id])
  end

end
