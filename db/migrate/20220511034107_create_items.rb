class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.integer :inventory

      t.timestamps
    end
  end
end
