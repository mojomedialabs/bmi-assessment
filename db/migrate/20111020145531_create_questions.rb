class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :section, :null => false
      t.text :content, :null => false
      t.integer :display_order, :null => false, :default => 0
      t.timestamps
    end
  end
end
