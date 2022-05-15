class ItemsController < ApplicationController
  def index
    @items = Item.alphabetize
  end

  def show
    @item = Item.find(params[:id])
  end
end
