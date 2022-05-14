class Item < ApplicationRecord
  has_many :shipment_items
  has_many :shipments, through: :shipment_items
end
