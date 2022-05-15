class ShipmentItem < ApplicationRecord
  belongs_to :shipment
  belongs_to :item
end
