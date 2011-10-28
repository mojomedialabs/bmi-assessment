class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question, :null => false
      t.text :content, :null => false
      t.integer :weight, :null => false, :default => 1
      t.integer :display_order, :null => false, :default => 0
      t.timestamps
    end
  end
end
