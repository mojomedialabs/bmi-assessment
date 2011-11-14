class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :resultable_id, :null => false
      t.string :resultable_type, :null => false
      t.integer :top, :null => false, :default => 1
      t.integer :bottom, :null => false, :default => 0
      t.text :content
      t.timestamps
    end
  end
end
