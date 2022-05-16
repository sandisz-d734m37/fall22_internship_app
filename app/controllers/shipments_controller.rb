class ShipmentsController < ApplicationController
  def show
    @shipment = Shipment.find(params[:id])
  end

  def index
    @shipments = Shipment.all.order(created_at: :desc)
  end

  def new
    @items = Item.all
  end

  def create
    # binding.pry
    shipment = Shipment.new(
      origin: params[:origin],
      destination: params[:destination],
      outgoing: params[:outgoing].to_i
    )
    if shipment.save
      counts = params[:item_count].reject{ |count| count.empty? }

      params[:selected_items].each_with_index do |item_id, index|
          ShipmentItem.create!(item_id: item_id, shipment_id: shipment.id, quantity: counts[index])
      end
      redirect_to "/shipments/#{shipment.id}"
    else
      redirect_to "/users/#{party.user_id}/movies/#{params[:movie_id]}/parties/new"
      flash[:invalid_origin] = "Invalid Data: Duration must be greater than or equal to the movie's runtime."
    end
  end
end
