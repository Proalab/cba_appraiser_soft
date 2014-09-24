class CreateTiphouses < ActiveRecord::Migration
  def change
    create_table :tiphouses do |t|
      t.integer :num_analog
      t.integer :o1
      t.integer :o2
      t.integer :o3
      t.integer :o4

      t.timestamps
    end
  end
end
