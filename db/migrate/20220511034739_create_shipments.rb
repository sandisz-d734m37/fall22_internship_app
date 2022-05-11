class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.string :origin
      t.string :destination
      t.boolean :outgoing
      t.boolean :arrived

      t.timestamps
    end
  end
end
