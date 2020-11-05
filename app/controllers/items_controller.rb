class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :item_create, only: [:create]
  before_action :item_find, only: [:create, :show, :edit, :update, :ensure_current_user, :destroy]
  before_action :ensure_current_user, only: [:create, :edit, :destroy]
  before_action :search_items, only: [:index, :search, :item_search]

  def index
    @items = Item.all.order("created_at DESC")
    @search_items = Item.all
    set_item_column
  end

  def new
    @item = Item.new
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
    @item_tag = ItemTags.new(item_params)
    if @item_tag.update(item_params, @item)
      redirect_to root_path
    else
      render :edit
    end
  end


  def item_search
    @posts = Item.search(params[:search])
    @items = @p.result
    render :index
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tagname LIKE ?', "%#{params[:keyword]}%"])
    render json:{ keyword: tag }
  end
  
  private
  
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :price,
      :status_id,
      :category_id,
      :delivery_charge_id,
      :shipment_source_id,
      :transport_days_id,
      :tagname,
      images: []
    ).merge(
      user_id: current_user.id,
      tag_id: params[:tagname]
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

  def search_items
    @p = Item.ransack(params[:q])
  end



  def set_item_column
    @item_name = Item.select("name").distinct
  end
  
end