class ShipmentsController < ApplicationController
  def show
    @shipment = Shipment.find(params[:id])
  end
end
