class ShipmentsController < ApplicationController
  def show
    @shipment = Shipment.find(params[:id])
  end

  def index
    @shipments = Shipment.all.order(created_at: :desc)
    @items = Item.all
  end

  def new
    @items = Item.all
  end

  def edit
    @shipment = Shipment.find(params[:id])
  end

  def create
    shipment = Shipment.new(
      origin: params[:origin],
      destination: params[:destination],
      outgoing: params[:outgoing].to_i
    )

    counts = params[:item_count].reject{ |count| count.empty? }

    if shipment.save && params[:selected_items] && counts.length == params[:selected_items].length

      params[:selected_items].each_with_index do |item_id, index|
          ShipmentItem.create!(item_id: item_id, shipment_id: shipment.id, quantity: counts[index])
      end

      shipment.items.each do |item|
        item.update_for_shipment(shipment)
      end
      redirect_to "/shipments/#{shipment.id}"
    else
      redirect_to "/shipments/new"
      flash[:invalid_origin] = "Origin must not be left blank"
      flash[:invalid_destination] = "Destination must not be left blank"
      flash[:invalid_selection] = "You must select items to create a shipment"
      flash[:invalid_count] = "You must enter an item count for all items"
    end
  end

  def update
    shipment = Shipment.find(params[:id])

    shipment.update({
      arrived: params[:arrived]
      })

    shipment.save
    unless shipment.outgoing
      shipment.items.each do |item|
        item.update_for_shipment(shipment)
      end
    end

    redirect_to "/shipments/#{shipment.id}"
  end
end
