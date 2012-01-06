class CreateRealizes < ActiveRecord::Migration
  def change
    create_table :realizes do |t|
      t.integer :expression_id
      t.integer :patron_id

      t.timestamps
    end
  end
end
