class ItemsController < ApplicationController
  def index
    @items = Item.alphabetize
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
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
end
