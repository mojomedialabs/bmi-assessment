class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.text :title, :null => false
      t.string :slug, :null => false
      t.text :description
      t.integer :display_order, :null => false, :default => 0
      t.integer :status, :null => false, :default => 1
      t.timestamps
    end
  end
end
