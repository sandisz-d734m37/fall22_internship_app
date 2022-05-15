class ItemsController < ApplicationController
  def index
    @items = Item.alphabetize
  end
end
