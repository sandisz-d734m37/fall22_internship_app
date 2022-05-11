class CreateShipmentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_items do |t|
      t.references :item, foreign_key: true
      t.references :shipment, foreign_key: true
      t.integer :quantity
    end
  end
end
