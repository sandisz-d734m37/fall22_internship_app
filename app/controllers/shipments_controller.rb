class ShipmentsController < ApplicationController
  def show
    @shipment = Shipment.find(params[:id])
  end

  def index
    @shipments = Shipment.all
  end
end
