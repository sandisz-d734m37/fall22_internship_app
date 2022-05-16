class ItemsController < ApplicationController
  def index
    @items = Item.alphabetize
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    item = Item.new({
      name: params[:name],
      description: params[:description],
      price: (params[:price].to_f * 100),
      inventory: params[:inventory].to_i
      })

    if item.save
      redirect_to "/items/#{item.id}"
    else
      redirect_to "/items/new"
      flash[:invalid_name] = "The name field cannot be blank"
    end
  end

  def update
    item = Item.find(params[:id])

    item.update({
      name: params[:name],
      description: params[:description],
      price: (params[:price].to_f * 100),
      inventory: params[:inventory].to_i
      })

    if item.save
      redirect_to "/items/#{item.id}"
    else
      redirect_to "/items/#{item.id}/edit"
      flash[:invalid_name] = "The name field cannot be blank"
    end
  end

  def destroy
    ShipmentItem.where("item_id = ?", params[:id]).destroy_all
    Item.find(params[:id]).destroy
    redirect_to '/items'
  end
end
