class CreateOwns < ActiveRecord::Migration
  def change
    create_table :owns do |t|
      t.integer :item_id
      t.integer :patron_id

      t.timestamps
    end
  end
end
