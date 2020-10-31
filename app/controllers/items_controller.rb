class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :item_create, only: [:create]
  before_action :item_find, only: [:create, :show, :edit, :update, :ensure_current_user, :destroy]
  before_action :ensure_current_user, only: [:create, :edit, :destroy]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = ItemTags.new
  end
  
  def create
  end

  def show
  end

  def edit
  end

  def destroy
    if user_signed_in? && @item.user_id == current_user.id
      @item.destroy
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


  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tagname LIKE ?', "%#{params[:keyword]}%"])
    binding.pry
    render json:{ keyword: tag }
  end
  
  private
  
  def item_params
    params.require(:item_tags).permit(
      :name,
      :description,
      :price,
      :status_id,
      :category_id,
      :delivery_charge_id,
      :shipment_source_id,
      :transport_days_id,
      :tagname,
      :content, images: []
    ).merge(
      user_id: current_user.id,
      tag_id: tag.id,
      )
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def ensure_current_user
    if user_signed_in? && @item.user_id != current_user.id
      redirect_to action: :index
    end
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def item_create
    @item = ItemTags.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

end